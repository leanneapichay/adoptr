from django.db import models


class Dog(models.Model):
    name = models.CharField(max_length=30)
    age = models.SmallIntegerField()
    breed = models.CharField(max_length=100)
    description = models.TextField()

