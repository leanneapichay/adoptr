from django.urls import path
from . import views

urlpatterns = [
    path('create-adopter/', views.signup_adopter),
    path('create-giver/', views.signup_giver),
    path('login/', views.login),
    path('adopter-data/', views.get_adopter_info),
    path('giver-data/', views.get_giver_info),
    path('account-type/', views.get_account_type),
    path('get-pets/', views.get_pets),
    path('adopter-id/', views.get_adopter),
    path('giver-id/', views.get_giver),
]