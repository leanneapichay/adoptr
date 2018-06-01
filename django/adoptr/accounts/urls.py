from django.urls import path
from . import views

urlpatterns = [
    path('create-adopter/', views.signup_adopter),
    path('create-giver/', views.signup_giver)
]