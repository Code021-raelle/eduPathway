from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import login, logout, authenticate
from .forms import CustomUserCreationForm, CustomUserChangeForm, CustomAuthenticationForm
from .models import UserProfile


def register(request):
    if request.method == 'POST':
        form = CustomUserCreationForm(request.POST)
        if form.is_valid():
            user = form.save()
            login(request, user)
            return redirect('course_list')
        else:
            return render(request, 'users/register.html', {'form': form})
    else:
        form = CustomUserCreationForm()
        return render(request, 'users/register.html', {'form': form})


def login_view(request):
    if request.method == "POST":
        form = CustomAuthenticationForm(data=request.POST)
        if form.is_valid():
            user = form.get_user()

            # Ensure the user has a profile before logging in
            profile, created = UserProfile.objects.get_or_create(user=user)

            login(request, user)
            return redirect('course_list')
    else:
        form = CustomAuthenticationForm()
    return render(request, 'users/login.html', {'form': form})


def logout_view(request):
    logout(request)
    return redirect('course_list')


def user_profile(request, username):
    profile = get_object_or_404(UserProfile, user__username=username)
    return render(request, 'profiles/profile.html', {'profile': profile})