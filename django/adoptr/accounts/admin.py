from django.contrib import admin
from .models import Adopter, Giver, User

admin.site.register(Adopter)
admin.site.register(Giver)
admin.site.register(User)
