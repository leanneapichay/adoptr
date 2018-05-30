from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('shelters/', include('shelters.urls')),
    path('dogs/', include('dogs.urls')),
    path('accounts/', include('accounts.urls')),
]
