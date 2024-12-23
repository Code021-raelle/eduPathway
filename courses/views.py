from django.contrib.auth.decorators import login_required
from django.shortcuts import render, get_object_or_404, redirect
from django.forms import ModelForm
from django.http import JsonResponse
from .models import (Course, UserCourseProgress, Lesson, Certificate, Review, Notification, Quiz, Question, Leaderboard,
                     Choice, DiscussionThread, DiscussionReply, CourseSerializer, CourseEngagement, UserProfile, UserProgress, StudyGroup, Message, Badge, UserBadge)
from django.db.models import Avg, Count, F
from django.contrib.admin.views.decorators import staff_member_required
from django.utils import timezone
from django.conf import settings
from rest_framework.views import APIView
from rest_framework.response import Response
from users.models import CustomUser
from .forms import CourseForm
from uuid import uuid4
import stripe

stripe.api_key = settings.STRIPE_SECRET_KEY

def course_payment(request, course_id):
    course = get_object_or_404(Course, id=course_id)
    session = stripe.checkout.Session.create(
        payment_method_types=['card'],
        line_items=[{
            'price_data': {
                'currency': 'usd',
                'product_data': {
                    'name': course.title,
                },
                'unit_amount': int(course.price * 100),
            },
            'quantity': 1,
        }],
        mode='payment',
        success_url=request.build_absolute_uri('/success/'),
        cancel_url=request.build_absolute_uri('/cancel/'),
    )
    return redirect(session.url, code=303)


class LessonForm(ModelForm):
    class Meta:
        model = Lesson
        fields = ['title', 'description', 'video_url', 'video', 'course']

class ReviewForm(ModelForm):
    class Meta:
        model = Review
        fields = ['rating', 'comment']


def course_detail(request, course_id):
    course = get_object_or_404(Course, id="course_id")
    progress, created = UserCourseProgress.objects.get_or_create(
        user=request.user,
        course=course
    )
    return render(request, 'courses/course_detail.html', {
        'course': course,
        'progress': progress,
    })


def course_list(request):
    courses = Course.objects.all()
    return render(request, 'courses/course_list.html', {'courses': courses})

def course_detail(request, pk):
    course = get_object_or_404(Course, pk=pk)
    return render(request, 'courses/course_detail.html', {'course': course})


def course_create(request):
    if request.method == 'POST':
        form = CourseForm(request.POST, request.FILES)
        if form.is_valid():
            course = form.save(commit=False)
            course.instructor = request.user
            course.save()
            return redirect('instructor_dashboard')
    else:
        form = CourseForm()

    return render(request, 'courses/course_create.html', {'form': form})


@login_required
def instructor_dashboard(request):
    if not request.user.is_instructor:
        return redirect('course_list')      # Restrict access to instructors
    courses = request.user.courses.all()
    return render(request, 'courses/instructor_dashboard.html', {'courses': courses})

@login_required
def add_lesson(request, course_id):
    course = get_object_or_404(Course, id=course_id, instructor=request.user)
    if request.method == "POST":
        form = LessonForm(request.POST, request.FILES)
        if form.is_valid():
            lesson = form.save(commit=False)
            lesson.course = course
            lesson.save()
            return redirect('instructor_dashboard')
        else:
            form = LessonForm()
        return render(request, 'courses/add_lesson.html', {'form': form, 'course': course})

@login_required
def complete_lesson(request, lesson_id):
    lesson = get_object_or_404(Lesson, id=lesson_id)
    progress = UserCourseProgress.objects.get(user=request.user, course=lesson.course)
    progress.completed_lessons.add(lesson)
    total_lessons = lesson.course.lessons.count()
    completed_lessons = progress.completed_lessons.count()
    progress.progress = (completed_lessons / total_lessons) * 100
    progress.save()
    return JsonResponse({'success': True, 'progress': progress.progress})


def generate_certificate(request, course_id):
    course = get_object_or_404(Course, id=course_id)
    progress = UserCourseProgress.objects.get(user=request.user, course=course)
    if progress.progress == 100.0:
        certificate, created = Certificate.objects.get_or_create(
            user=request.user,
            course=course,
            defaults={'certificate_code': str(uuid4())[:16]}
        )
        return render(request, 'courses/certificate.html', {'certificate': certificate})
    else:
        return redirect('course_detail', course_id=course_id)


@login_required
def add_review(request, course_id):
    course = get_object_or_404(Course, id=course_id)
    if request.method == "POST":
        form = ReviewForm(request.POST)
        if form.is_valid():
            review = form.save(commit=False)
            review.user = request.user
            review.course = course
            review.save()
            return redirect('course_detail', course_id=course_id)
        else:
            form = ReviewForm()
        return render(request, 'courses/add_review.html', {'form': form, 'course': course})


@staff_member_required
def admin_dashboard(request):
    courses = Course.objects.annotate(
        enrollments=Count('enrollment'),
        avg_progress=Avg('enrollment__usercourseprogress__progress')
    ).order_by('-enrollments')

    data = {
        'total_users': CustomUser.objects.count(),
        'total_courses': Course.objects.count(),
        'most_popular_courses': courses[:5],
        'courses': courses
    }
    return render(request, 'admin/dashboard.html', data)


def send_notification(user, message):
    Notification.objects.create(user=user, message=message, created_at=timezone.now())

def complete_course(user, course):
    progress = UserCourseProgress.objects.get(user=user, course=course)
    if progress.progress == 100.0:
        send_notification(user, f"Congratulations! You've completed the course {course.title}.")


@login_required
def view_notifications(request):
    notifications = request.user.notifications.filter(is_read=False)
    notifications.update(is_read=True)
    return render(request, 'users/notifications.html', {'notifications': notifications})


@login_required
def take_quiz(request, quiz_id):
    quiz = get_object_or_404(Quiz, id=quiz_id)
    if request.method == 'POST':
        score = 0
        for question in quiz.questions.all():
            selected_choice = request.POST.get(str(question.id))
            if selected_choice:
                choice = Choice.objects.get(id=selected_choice)
                if choice.is_correct:
                    score += 1
        return render(request, 'courses/quiz_result.html', {
            'quiz': quiz,
            'score': score,
            'total': quiz.questions.count()
        })
    return render(request, 'courses/take_quiz.html', {'quiz': quiz})


def live_sessions(request, course_id):
    course = get_object_or_404(Course, id=course_id)
    sessions = course.live_sessions.filter(date__gte=timezone.now())
    return render(request, 'courses/live_sessions.html', {'course': course, 'sessions': sessions})


def course_threads(request, course_id):
    course = get_object_or_404(Course, id=course_id)
    threads = course.threads.all()
    return render(request, 'forums/threads.html', {'course': course, 'threads': threads})


@login_required
def create_thread(request, course_id):
    if request.method == "POST":
        title = request.POST.get('title')
        course = get_object_or_404(Course, id=course_id)
        DiscussionThread.objects.create(user=request.user, course=course, title=title)
        return redirect('course_threads', course_id=course_id)
    return render(request, 'forums/create_thread.html', {'course_id': course_id})


class CourseListView(APIView):
    def get(self, request):
        courses = Course.objects.all()
        serializer = CourseSerializer(courses, many=True)
        return Response(serializer.data)


class RecommendationsView(APIView):
    def get(self, request):
        user = request.user
        if user.is_authenticated:
            recommended_courses = recommended_courses(user)
            serializer = CourseSerializer(recommended_courses, many=True)
            return Response(serializer.data)
        return Response({"error": "Unauthorized"}, status=401)


def analytics_dashboard(request):
    courses = Course.objects.all()
    analytics = []
    for course in courses:
        engagement = CourseEngagement.objects.filter(course=course)
        total_time = sum([e.time_spent.total_seconds() for e in engagement], 0)
        completion_rate = engagement.filter(completed=True).count() / engagement.count() * 100 if engagement.count() > 0 else 0
        analytics.append({
            'course': course.title,
            'total_time_spent': total_time,
            'completion_rate': completion_rate,
        })
    return render(request, 'dashboard/analytics.html', {'analytics': analytics})


def recommend_next_module(user, course):
    progress = UserProgress.objects.get(user=user, course=course)
    all_modules = course.modules.all()
    completed_ids = progress.completed_modules.values_list('id', flat=True)
    remaining_modules = all_modules.exclude(id__in=completed_ids)

    # Simple logic: recommend based on quiz performance
    last_scores = progress.quiz_scores.get(str(course.id), [])
    if len(last_scores) > 0 and sum(last_scores) / len(last_scores) < 50:
        # Suggest a review module if performance is low
        review_module = course.modules.filter(is_review=True).first()
        if review_module:
            return review_module
        
    # Otherwise, recommend the next uncompleted module
    return remaining_modules.first()


class NextModuleView(APIView):
    def get(self, request, course_id):
        course = get_object_or_404(Course, id=course_id)
        recommended_module = recommend_next_module(request.user, course)
        if recommended_module:
            return Response({'module_id': recommended_module.id, 'title': recommended_module.title})
        return Response({'error': 'No modules to recommend'}, status=404)


def user_profile(request, username):
    profile = get_object_or_404(UserProfile, user__username=username)
    return render(request, 'profiles/profile.html', {'profile': profile})


def course_create(request):
    return render(request, 'courses/course_create.html')


def course_groups(request, course_id):
    course = get_object_or_404(Course, id=course_id)
    groups = StudyGroup.objects.filter(course=course)
    return render(request, 'groups/course_groups.html', {'course': course, 'groups': groups})


@login_required
def join_group(request, group_id):
    group = get_object_or_404(StudyGroup, id=group_id)
    group.members.add(request.user)
    return redirect('course_groups', course_id=group.course.id)


@login_required
def inbox(request):
    messages = Message.objects.filter(receiver=request.user).order_by('-timestamp')
    return render(request, 'messages/inbox.html', {'messages': messages})


@login_required
def send_message(request):
    if request.method == "POST":
        receiver = CustomUser.objects.get(username=request.POST.get('receiver'))
        content = request.POST.get('content')
        Message.objects.create(sender=request.user, receiver=receiver, content=content)
        return redirect('inbox')
    return render(request, 'messages/send_message.html')


def award_badges(user):
    badges = Badge.objects.all()
    for badge in badges:
        criteria = badge.criteria
        if 'completed_courses' in criteria:
            completed_count = user.profile.completed_courses.count()
            if completed_count >= criteria['completed_courses']:
                UserBadge.objects.get_or_create(user=user, badge=badge)


def user_badges(request):
    badges = UserBadge.objects.filter(user=request.user)
    return render(request, 'gamification/badges.html', {'badges': badges})

def update_leaderboard(user, points):
    leaderboard, created = Leaderboard.objects.get_or_create(user=user)
    leaderboard.score += points
    leaderboard.save()

def view_leaderboard(request):
    leaderboard = Leaderboard.objects.all().order_by('-score')[:10]
    return render(request, 'gamification/leaderboard.html', {'leaderboard': leaderboard})
