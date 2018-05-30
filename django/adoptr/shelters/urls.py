from django.urls import path
from . import views

urlpatterns = [
    path('get-zip-shelters/', views.get_zip_shelters),
    path('shelter-info/', views.get_shelter),
]