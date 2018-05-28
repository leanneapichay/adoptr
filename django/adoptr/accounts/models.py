from django.db import models
from django.contrib.auth.models import User
from shelters.models import Shelter


class Adopter(models.Model):

    user = models.ForeignKey(User, on_delete=models.CASCADE)
    zip_code = models.SmallIntegerField()
    availability = models.SmallIntegerField()
    size = models.IntegerField()
    age = models.IntegerField()
    traits = models.IntegerField()

    def __str__(self):
        return self.user.email


class Giver(models.Model):

    user = models.ForeignKey(User, on_delete=models.CASCADE)
    zip_code = models.SmallIntegerField()
    independent = models.BooleanField()
    shelter = models.ForeignKey(Shelter, on_delete=models.CASCADE, null=True, blank=True)

    def __str__(self):
        return self.user.email




