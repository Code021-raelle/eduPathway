from django import forms
from django.contrib.auth.forms import UserCreationForm, UserChangeForm, AuthenticationForm
from .models import CustomUser, UserProfile
from django.contrib.auth import get_user_model

CustomUser = get_user_model()


class CustomUserCreationForm(UserCreationForm):
    """
    Form for creating a new user with the custom user model.
    """
    email = forms.EmailField(required=True, widget=forms.EmailInput(attrs={
        'class': 'form-control',
        'placeholder': 'Enter your email',
    }))

    class Meta:
        model = CustomUser
        fields = ('username', 'first_name', 'last_name', 'email', 'is_instructor', 'is_student', 'password1', 'password2')
        widgets = {
            'username': forms.TextInput(attrs={
                'class': 'form-control',
                'placeholder': 'Enter your username',
            }),
            'is_instructor': forms.CheckboxInput(attrs={
                'class': 'form-check-input',
            }),
            'is_student': forms.CheckboxInput(attrs={
                'class': 'form-check-input',
            }),
        }


class CustomUserChangeForm(UserChangeForm):
    class Meta:
        model = CustomUser
        fields = ('username', 'email')


class CustomAuthenticationForm(AuthenticationForm):
    """
    Authentication form customized for the custom user model.
    """
    username = forms.CharField(widget=forms.TextInput(attrs={
        'class': 'form-control',
        'placeholder': 'Enter your username',
    }))
    password = forms.CharField(widget=forms.PasswordInput(attrs={
        'class': 'form-control',
        'placeholder': 'Enter your password',
    }))
    
    class Meta:
        model = CustomUser

    
class EditProfileForm(forms.ModelForm):
    class Meta:
        model = UserProfile
        fields = ('__all__')
