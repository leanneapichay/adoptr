from django.urls import path
from . import views

urlpatterns = [
    path('get-dogs-shelters/', views.get_dogs_shelter),
    path('dog-info/', views.get_dog_info),
    path('create-dog/', views.create_dog),
]