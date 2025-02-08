from django.contrib.auth.models import AbstractUser
from django.db import models
from django.conf import settings

class CustomUser(AbstractUser):
    """
    Custom user model extending Django's AbstractUser.
    Includes additional fields to distinguish user roles.
    """
    

    is_instructor = models.BooleanField(default=False, verbose_name="Is Instructor")
    is_student = models.BooleanField(default=True, verbose_name="Is Student")
    
    def save(self, *args, **kwargs):
        """
        Override save to ensure a user cannot be both a student and an instructor.
        """
        if self.is_instructor and self.is_student:
            raise ValueError("A user cannot be both an instructor and a student.")
        super().save(*args, **kwargs)


class Tag(models.Model):
    name = models.CharField(max_length=100)


class UserProfile(models.Model):
    from courses.models import Course
    user = models.OneToOneField(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='userprofile')
    profile_picture = models.ImageField(upload_to='profile_pictures/', null=True, blank=True)
    bio = models.TextField(blank=True, null=True)
    interests = models.ManyToManyField('Tag', blank=True)
    completed_courses = models.ManyToManyField(Course, blank=True)
    last_seen = models.DateTimeField(auto_now=True)     # For "last seen" status
    status_message = models.TextField(blank=True, null=True)
    status_image = models.ImageField(upload_to='status/', blank=True, null=True)

    def __str__(self):
        return f"{self.user.username}'s Profile"
    