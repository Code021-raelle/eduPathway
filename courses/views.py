from django.contrib.auth.decorators import login_required
from django.shortcuts import render, get_object_or_404, redirect
from django.template.loader import render_to_string
from django.contrib.auth.signals import user_logged_in
from django.dispatch import receiver
from django.contrib import messages
from django.forms import ModelForm
from django.http import JsonResponse, HttpResponse, HttpResponseRedirect
from .models import (Course, UserCourseProgress, Lesson, Certificate, Review, Notification, Quiz, Question, Leaderboard,
                     Choice, DiscussionThread, DiscussionReply, CourseSerializer, CourseEngagement, UserProgress, StudyGroup, Message, Badge, UserBadge)
from django.db.models import Avg, Count, F, Sum
from django.contrib.admin.views.decorators import staff_member_required
from django.utils import timezone
from django.conf import settings
from rest_framework.views import APIView
from rest_framework.response import Response
from users.models import CustomUser
from .forms import CourseForm, LessonForm, ReviewForm
from django.utils.timezone import now
from django.views.generic import UpdateView, DetailView, UpdateView
from django.views.decorators.csrf import csrf_exempt
from django.urls import reverse_lazy
from weasyprint import HTML
from uuid import uuid4
from dotenv import load_dotenv
import stripe
import json
import openai
import groq
import os


stripe.api_key = settings.STRIPE_SECRET_KEY

class CourseEditView(UpdateView):
    model = Course
    form_class = CourseForm
    template_name = 'courses/course_edit.html'

    def form_valid(self, form):
        course = form.save(commit=False)
        course.instructor = self.request.user   # Ensure only instructor can edit
        course.save()
        return redirect('instructor_dashboard')
    
class LessonDetailView(DetailView):
    model = Lesson
    template_name = 'courses/lesson_detail.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        lesson = self.get_object()
        progress, created = UserCourseProgress.objects.get_or_create(user=self.request.user, course=lesson.course)

        context['progress'] = progress
        return context
    
class EditLessonView(UpdateView):
    model = Lesson
    form_class = LessonForm
    template_name = 'courses/edit_lesson.html'

    def get_success_url(self):
        return reverse_lazy('lesson_detail', kwargs={'pk': self.object.pk})
    
    def dispatch(self, request, *args, **kwargs):
        lesson = self.get_object()
        if not request.user.is_authenticated or not request.user.is_instructor:
            return redirect('lesson_detail', pk=lesson.pk)
        return super().dispatch(request, *args, **kwargs)

@receiver(user_logged_in)
def add_welcome_notification(sender, request, user, **kwargs):
    """Ensure existing users receive a welcome notification if they haven't already."""
    if not Notification.objects.filter(user=user, message__icontains="Welcome to our platform").exists():
        Notification.objects.create(
            user=user,
            message="Welcome to our platform! We're excited to have you here 🎉."
        )
    else:
        pass


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


def landing_page(request):
    return render(request, 'landing_page.html')

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
    from users.models import UserProfile
    lesson = get_object_or_404(Lesson, id=lesson_id)
    profile = request.user.userprofile

    if lesson not in profile.completed_courses.all():
        profile.completed_courses.add(lesson.course) # Track course completion
        profile.add_points(10)  # Award 10 points for completing a lesson

        try:
            progress = UserCourseProgress.objects.get(user=request.user, course=lesson.course)
        except UserCourseProgress.DoesNotExist:
            progress = UserCourseProgress.objects.create(user=request.user, course=lesson.course)

        progress.completed_lessons.add(lesson)
        total_lessons = lesson.course.lessons.count()
        completed_lessons = progress.completed_lessons.count()
        progress.progress = (completed_lessons / total_lessons) * 100
        progress.save()
        return JsonResponse({'success': True, 'progress': progress.progress})
    return JsonResponse({"message": "Lesson completed!", "points": profile.points})


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
    

def download_certificate(request, course_id):
    course = get_object_or_404(Course, id=course_id)
    certificate = Certificate.objects.get(user=request.user, course=course)
    html = render_to_string('courses/certificate.html', {'certificate': certificate})
    pdf_file = HTML(string=html).write_pdf()

    response = HttpResponse(pdf_file, content_type='application/pdf')
    response['Content-Disposition'] = 'attachment; filename="certificate.pdf"'
    return response


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
            return redirect('course_detail', pk=course_id)
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
        send_notification(user, f"Congratulations! You've completed the course 🎉 {course.title}.")


@login_required
def view_notifications(request):
    notifications = request.user.notifications.filter(is_read=False)
    notifications = Notification.objects.filter(user=request.user).order_by('-created_at')
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


def thread_replies(request, course_id, thread_id):
    course = get_object_or_404(Course, id=course_id)
    thread = get_object_or_404(DiscussionThread, id=thread_id, course=course)

    if request.method == "POST":
        content = request.POST.get('content')
        if content:
            DiscussionReply.objects.create(
                thread=thread,
                user=request.user,
                content=content
            )
        return redirect('thread_replies', course_id=course.id, thread_id=thread.id)
    
    replies = thread.replies.all()
    return render(request, 'forums/thread_replies.html', {'thread': thread, 'replies': replies})


@login_required
def add_reply(request, course_id, thread_id):
    thread = get_object_or_404(DiscussionThread, id=thread_id)
    if request.method == 'POST':
        reply_content = request.POST.get('content')
        if reply_content:
            reply = DiscussionReply.objects.create(
                thread=thread,
                user=request.user,
                content=reply_content
            )

            # Notify the thread owner
            if thread.user != request.user:     # Don't notify user if they're replying to their own thread
                Notification.objects.create(
                    user=thread.user,
                    thread=thread,
                    reply=reply,
                    message=f"{request.user.username} replied to your thread '{thread.title}'"
                )
            
            return HttpResponseRedirect(request.META.get('HTTP_REFERER'))
    return HttpResponseRedirect(request.META.get('HTTP_REFERER'))


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
        
        # Use aggregate() to optimize total time calculation
        total_seconds = engagement.aggregate(total_time=Sum('time_spent'))['total_time'] or 0

        # Calculate completion rate safely
        engagement_count = engagement.count()
        completed_count = engagement.filter(completed=True).count()
        completoin_rate = (completed_count / engagement_count * 100) if engagement_count > 0 else 0

        # Convert total_seconds to hh:mm:ss format
        hours = total_seconds // 3600
        minutes = (total_seconds % 3600) // 60
        seconds = total_seconds % 60
        formatted_time = f"{hours}h {minutes}m {seconds}s"

        analytics.append({
            'course': course.title,
            'total_time_spent': formatted_time,
            'completoin_rate': round(completoin_rate, 2),
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
    received_messages = Message.objects.filter(receiver=request.user).order_by('-timestamp')

    # Handle reply
    if request.method == 'POST':
        original_message_id = request.POST.get('original_message_id')
        reply_content = request.POST.get('reply_content')

        if original_message_id and reply_content:
            original_message = get_object_or_404(Message, id=original_message_id)
            Message.objects.create(
                sender=request.user,
                receiver=original_message.sender,
                content=reply_content,
                parent=original_message
            )
            return redirect('inbox')

    return render(request, 'messages/inbox.html', {'messages': received_messages})


@login_required
def send_message(request):
    if request.method == "POST":
        receiver = CustomUser.objects.get(username=request.POST.get('receiver'))
        content = request.POST.get('content')
        attachment = request.FILES.get('attachment')

        message = Message.objects.create(
            sender=request.user,
            receiver=receiver,
            content=content,
            attachment=attachment
        )
        receiver.userprofile.last_seen = now()
        receiver.userprofile.save()
        return redirect('inbox')
    return render(request, 'messages/send_message.html')


@login_required
def chat(request):
    user = request.user
    conversations = Message.objects.filter(receiver=user).distinct('sender') | Message.objects.filter(sender=user).distinct('receiver')
    
    chat_with = request.GET.get('chat_with')
    active_conversation = []
    active_user = None

    if chat_with:
        active_user = CustomUser.objects.get(username=chat_with)
        active_conversation = Message.objects.filter(
            sender=user, receiver=active_user
        ) | Message.objects.filter(
            sender=active_user, receiver=user
        ).order_by('timestamp')

    if request.method == 'POST' and active_user:
        content = request.POST.get('content')
        Message.objects.create(sender=user, receiver=active_user, content=content)
        return redirect(f'?chat_with={active_user.username}')

    return render(request, 'chat.html', {
        'user': user,
        'conversations': conversations,
        'active_conversation': active_conversation,
        'active_user': active_user,
    })


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

def ask_ai(request):
    return render(request, 'messages/ask_ai.html')

@csrf_exempt
def ask_ai_api(request):
    if request.method == "POST":
        try:
            data = json.loads(request.body)
            user_message = data.get("message", "")

            groq_api_key = settings.GROQ_API_KEY
            model = settings.GROQ_MODEL

            if not groq_api_key:
                return JsonResponse({"error": "Missing Groq API key"}, status=500)

            # Initialize Groq client
            client = groq.Client(api_key=groq_api_key)

            response = client.chat.completions.create(
                model=model,  
                messages=[{"role": "user", "content": user_message}],
                temperature=0.7
            )

            ai_response = response.choices[0].message.content
            return JsonResponse({"response": ai_response})

        except groq.GroqError as e:
            return JsonResponse({"error": f"Groq API error: {str(e)}"}, status=500)

        except Exception as e:
            return JsonResponse({"error": f"Internal server error: {str(e)}"}, status=500)

    return JsonResponse({"error": "Invalid request method"}, status=405)
