from django.db import models


class Shelter(models.Model):
    name = models.CharField(max_length=200)
    location = models.TextField()
    description = models.TextField()

