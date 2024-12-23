from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .forms import CustomUserChangeForm, CustomUserCreationForm
from .models import CustomUser


#class CustomUserAdmin(UserAdmin):
 #   add_form = CustomUserCreationForm
  #  form = CustomUserChangeForm
   # model = CustomUser
    #list_display = ['username', 'email', 'is_instructor', 'is_active']

#admin.site.register(CustomUser, CustomUserAdmin)


@admin.register(CustomUser)
class CustomUserAdmin(UserAdmin):
    model = CustomUser
    fieldsets = UserAdmin.fieldsets + (
        (None, {'fields': ('is_instructor', 'is_student')}),
    )
    list_display = ['username', 'email', 'is_instructor', 'is_student']
    list_filter = ['is_instructor', 'is_student']
