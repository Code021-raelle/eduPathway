from django.db import models
from django.conf import settings
from users.models import CustomUser
from rest_framework import serializers
from django.core.files.storage import FileSystemStorage
from datetime import timedelta
from django.db.models.signals import post_save
from django.dispatch import receiver
from asgiref.sync import async_to_sync
from channels.layers import get_channel_layer
import json


class Module(models.Model):
    title = models.CharField(max_length=255)
    description = models.TextField()


class Course(models.Model):
    title = models.CharField(max_length=255, help_text="Enter the course title.")
    description = models.TextField(help_text="Enter a brief description of the course.")
    tags = models.ManyToManyField('Tag', blank=True, help_text="Select tags for course.")
    price = models.DecimalField(max_digits=10, decimal_places=2, default=0.00, help_text="Enter the course price.")
    image = models.ImageField(upload_to='courses/%Y/%m/%d', null=True, blank=True, help_text="Upload an image for the course.")
    instructor = models.ForeignKey(
        settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="courses", verbose_name="Course Creator"
    )
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ['-created_at']      # Sort courses by creation date descending

    def __str__(self):
        return self.title


class Tag(models.Model):
    name = models.CharField(max_length=100)


class Lesson(models.Model):
    course = models.ForeignKey(Course, on_delete=models.CASCADE, related_name="lessons")
    title = models.CharField(max_length=255)
    description = models.TextField()
    thumbnail = models.ImageField(upload_to='thumbnails/', blank=True, null=True)
    video_url = models.URLField()
    video = models.FileField(upload_to='lessons/%Y/%m/%d', default="https://www.example.com/placeholder-video.mp4")
    resources = models.FileField(upload_to='resources/', blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.title

class UserCourseProgress(models.Model):
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    course = models.ForeignKey(Course, on_delete=models.CASCADE)
    completed_lessons = models.ManyToManyField('Lesson', blank=True)
    progress = models.FloatField(default=0.0)  # Percentage of course completed

class Certificate(models.Model):
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    course = models.ForeignKey(Course, on_delete=models.CASCADE)
    issued_date = models.DateTimeField(auto_now_add=True)
    Certificate_code = models.CharField(max_length=16, unique=True)

class Review(models.Model):
    course = models.ForeignKey(Course, on_delete=models.CASCADE, related_name="reviews")
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    rating = models.IntegerField(choices=[(i, i) for i in range(1, 6)])     # 1 to 5
    comment = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)

class Notification(models.Model):
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE, related_name="notifications")
    thread = models.ForeignKey('DiscussionThread', on_delete=models.Case, null=True, blank=True)
    reply = models.ForeignKey('DiscussionReply', on_delete=models.CASCADE, null=True, blank=True)
    message = models.TextField()
    is_read = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Notifiation for {self.user.username}: {self.message}"


class Quiz(models.Model):
    course = models.ForeignKey(Course, on_delete=models.CASCADE, related_name="quizzes")
    title = models.CharField(max_length=255)


class Question(models.Model):
    quiz = models.ForeignKey(Quiz, on_delete=models.CASCADE, related_name="questions")
    text = models.TextField()


class Choice(models.Model):
    question = models.ForeignKey(Question, on_delete=models.CASCADE, related_name="choices")
    text = models.CharField(max_length=255)
    is_correct = models.BooleanField(default=False)


class LiveSession(models.Model):
    course = models.ForeignKey(Course, on_delete=models.CASCADE, related_name="live_sessions")
    title = models.CharField(max_length=255)
    description = models.TextField(blank=True, null=True)
    date = models.DateTimeField()
    duration_minutes = models.IntegerField()
    link = models.URLField()    # e.g., Zoom/Google Meet link


class Order(models.Model):
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    course = models.ForeignKey(Course, on_delete=models.CASCADE)
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    payment_status = models.BooleanField(default=False)
    payment_id = models.CharField(max_length=255, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)


class DiscussionThread(models.Model):
    course = models.ForeignKey(Course, on_delete=models.CASCADE, related_name="threads")
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    title = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)


class DiscussionReply(models.Model):
    thread = models.ForeignKey(DiscussionThread, on_delete=models.CASCADE, related_name="replies")
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    content = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)


class CourseEngagement(models.Model):
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    course = models.ForeignKey(Course, on_delete=models.CASCADE)
    time_spent = models.DurationField(default=timedelta())
    completed = models.BooleanField(default=False)
    last_accessed = models.DateTimeField(auto_now=True)


class CourseSerializer(serializers.ModelSerializer):
    class Meta:
        model = Course
        fields = ['id', 'title', 'description', 'price']


# Recommend courses with similar tags
def recommend_courses(user):
    enrolled_courses = user.enrolled_courses.all()
    tags = Tag.objects.filter(course__in=enrolled_courses).distinct()
    recommendations = Course.objects.filter(tags__in=tags).exclude(id__in=enrolled_courses)
    return recommendations.distinct()


class UserProgress(models.Model):
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    course = models.ForeignKey(Course, on_delete=models.CASCADE)
    completed_modules = models.ManyToManyField('Module', blank=True, related_name='completed_by_users')
    quiz_scores = models.JSONField(default=dict)


class StudyGroup(models.Model):
    name = models.CharField(max_length=255)
    course = models.ForeignKey(Course, on_delete=models.CASCADE)
    members = models.ManyToManyField(CustomUser, related_name="study_groups")
    description = models.TextField()


class Message(models.Model):
    sender = models.ForeignKey(CustomUser, on_delete=models.CASCADE, related_name="sent_messages")
    receiver = models.ForeignKey(CustomUser, on_delete=models.CASCADE, related_name="received_messages")
    content = models.TextField()
    timestamp = models.DateTimeField(auto_now_add=True)
    is_read = models.BooleanField(default=False)
    attachment = models.FileField(upload_to='attachments/', blank=True, null=True)
    parent = models.ForeignKey('self', on_delete=models.CASCADE, null=True, blank=True, related_name='replies')

    def __str__(self):
        return f"From {self.sender} to {self.receiver}: {self.content}"

# Signal to send updates
def broadcast_message(sender, instance, **kwargs):
    channel_layer = get_channel_layer()
    room_group_name = f'chat_{instance.receiver.username}'

    async_to_sync(channel_layer.group_send)(
        room_group_name,
        {
            'type': 'chat_message',
            'message': json.dumps({
                'sender': instance.sender.username,
                'content': instance.content,
                'timestamp': instance.timestamp.strftime('%Y-%m-%d %H:%M:%S'),
            }),
        }
    )

post_save.connect(broadcast_message, sender=Message)

class Badge(models.Model):
    name = models.CharField(max_length=255)
    description = models.TextField()
    icon = models.ImageField(upload_to='badges/')
    criteria = models.JSONField()


class UserBadge(models.Model):
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    badge = models.ForeignKey(Badge, on_delete=models.CASCADE)
    awarded_date = models.DateTimeField(auto_now_add=True)


class Leaderboard(models.Model):
    user = models.OneToOneField(CustomUser, on_delete=models.CASCADE, related_name='leaderboard')
    score = models.IntegerField(default=0)