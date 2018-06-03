from django.db import models
from shelters.models import Shelter
from accounts.models import User


class Dog(models.Model):
    name = models.CharField(max_length=30)
    age = models.SmallIntegerField()
    age_range = models.SmallIntegerField()
    breed = models.CharField(max_length=100)
    description = models.TextField()
    active = models.BooleanField()
    trained = models.BooleanField()
    hypoallergenic = models.BooleanField()
    size = models.SmallIntegerField()
    shelter = models.ForeignKey(Shelter, on_delete=models.CASCADE, null=True, blank=True)
    owner = models.ForeignKey(User, on_delete=models.CASCADE, null=True, blank=True)

    def __str__(self):
        return self.name



