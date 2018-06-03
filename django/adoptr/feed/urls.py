from django.urls import path
from . import views

urlpatterns = [
    path('get-feed/', views.feed),
    path('matches/', views.get_non_completed_matches),
    path('completed-matches/', views.get_completed_matches),
    path('accept/', views.accept_match_giver),
    path('make-pp-match/', views.create_match_pp),
]