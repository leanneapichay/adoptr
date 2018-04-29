from django.db import models
from shelters.models import Shelter


class Dog(models.Model):
    name = models.CharField(max_length=30)
    age = models.SmallIntegerField()
    breed = models.CharField(max_length=100)
    description = models.TextField()
    shelter = models.ForeignKey(Shelter, on_delete=models.CASCADE)
