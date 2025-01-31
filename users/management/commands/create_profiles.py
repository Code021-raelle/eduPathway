from django.core.management.base import BaseCommand
from users.models import CustomUser, UserProfile

class Command(BaseCommand):
    help = "Create profiles for all users who don't have one"

    def handle(self, *args, **kwargs):
        for user in CustomUser.objects.all():
            UserProfile.objects.get_or_create(user=user)
        self.stdout.write(self.style.SUCCESS("Profiles created for all users."))
        