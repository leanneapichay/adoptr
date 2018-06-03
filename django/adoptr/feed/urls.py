from django.urls import path
from . import views

urlpatterns = [
    path('get-feed/', views.feed),
]