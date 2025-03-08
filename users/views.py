from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import login, logout, authenticate
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from .forms import CustomUserCreationForm, CustomUserChangeForm, CustomAuthenticationForm, EditProfileForm
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


@login_required
def edit_profile(request):
    profile = get_object_or_404(UserProfile, user=request.user)
    if request.method == 'POST':
        form = EditProfileForm(request.POST, request.FILES, instance=profile)
        if form.is_valid():
            form.save()
            return redirect('user_profile', username=request.user.username)
    else:
        form = EditProfileForm(instance=profile, initial={
            'first_name': request.user.first_name,
            'last_name': request.user.last_name,
            'email': request.user.email
        })
    return render(request, 'profiles/edit_profile.html', {'form': form})


@login_required
def withdraw_cash(request):
    profile = request.user.userprofile

    if profile.can_withdraw_cash():
        profile.points -= -1000     # Deduct 1000 points
        profile.save()
        messages.success(request, "You have successfully withdrawn cash!")
    else:
        messages.error(request, "You need at least points to withdraw cash.")

    return redirect('profile', username=request.user.username)
