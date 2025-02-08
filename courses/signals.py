from django.db.models.signals import post_save
from django.dispatch import receiver
from django.contrib.auth.models import User
from .models import Notification, CustomUser

@receiver(post_save, sender=CustomUser)
def send_welcome_notitfication(sender, instance, created, **kwargs):
    if created:     # Only triggers for new users
        Notification.objects.create(
            user=instance,
            message="Welcome to our EduPathway! We're exicted to have you here. "
        )