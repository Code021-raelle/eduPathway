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

