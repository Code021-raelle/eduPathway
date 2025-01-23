from django import forms
from .models import Course, Lesson, Review, UserProfile

class CourseForm(forms.ModelForm):
    class Meta:
        model = Course
        fields = ('__all__')


class LessonForm(forms.ModelForm):
    class Meta:
        model = Lesson
        fields = ('__all__')

class ReviewForm(forms.ModelForm):
    class Meta:
        model = Review
        fields = ['rating', 'comment']


class EditProfileForm(forms.ModelForm):
    username = forms.CharField(max_length=30, required=False, label="Username")
    first_name = forms.CharField(max_length=30, required=False, label="First Name")
    last_name = forms.CharField(max_length=30, required=False, label="Last Name")
    email = forms.EmailField(required=True, label="Email")

    class Meta:
        model = UserProfile
        fields = ['bio', 'profile_picture']

    def save(self, commit=True):
        profile = super().save(commit=False)
        user = profile.user
        user.username = self.cleaned_data['username']
        user.first_name = self.cleaned_data['first_name']
        user.last_name = self.cleaned_data['last_name']
        user.email = self.cleaned_data['email']
        if commit:
            user.save()
            profile.save()
        return profile
