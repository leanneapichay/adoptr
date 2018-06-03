from django.urls import path
from . import views

urlpatterns = [
    path('create-adopter/', views.signup_adopter),
    path('create-giver/', views.signup_giver),
    path('login/', views.login),
    path('adopter-data/', views.get_adopter_info),
    path('giver-data/', views.get_giver_info)
]