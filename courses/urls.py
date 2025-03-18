from django.urls import path
from . import views
from .views import CourseListView, CourseEditView, LessonDetailView, EditLessonView

urlpatterns = [
    path('', views.landing_page, name='landing_page'),
    path('courses/list', views.course_list, name='course_list'),
    path('courses/create/', views.course_create, name='course_create'),
    path('course/edit/<int:pk>/', CourseEditView.as_view(), name='edit_course'),
    path('<int:pk>/', views.course_detail, name='course_detail'),
    path('instructor/dashboard/', views.instructor_dashboard, name='instructor_dashboard'),
    path('course/<int:course_id>/add_lesson/', views.add_lesson, name='add_lesson'),
    path('lesson/<int:pk>/', LessonDetailView.as_view(), name='lesson_detail'),
    path('lesson/<int:pk>/edit/', EditLessonView.as_view(), name='edit_lesson'),
    path('lessons/<int:lesson_id>/complete/', views.complete_lesson, name='complete_lesson'),
    path('course/<int:course_id>/certificate/', views.generate_certificate, name='generate_certificate'),
    path('course/<int:course_id>/review/', views.add_review, name='add_review'),
    path('admin/dashboard/', views.admin_dashboard, name='admin_dashboard'),
    path('notifications/', views.view_notifications, name='view_notifications'),
    path('quiz/<int:quiz_id>/', views.take_quiz, name='take_quiz'),
    path('course/<int:course_id>/live_sessions/', views.live_sessions, name='live_sessions'),
    path('<int:course_id>/payment/', views.course_payment, name='course_payment'),
    path('course/<int:course_id>/threads/', views.course_threads, name='course_threads'),
    path('course/<int:course_id>/threads/create/', views.create_thread, name='create_thread'),
    path('course/<int:course_id>/threads/<int:thread_id>/', views.thread_replies, name='thread_replies'),
    path('dashboard/analytics/', views.analytics_dashboard, name='analytics_dashboard'),
    path('gamification/badges/', views.user_badges, name='user_badges'),
    path('gamification/leaderboard/', views.view_leaderboard, name='view_leaderboard'),
    path('inbox/', views.inbox, name='inbox'),
    path('chats/', views.send_message, name='send_message'),
    path('chat/', views.chat, name='chat'),
    path('ask_ai/', views.ask_ai, name='ask_ai'), 
    path('api/courses/', CourseListView.as_view(), name='api_courses'),
]
