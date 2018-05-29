from django.db import models
from shelters.models import Shelter
from django.contrib.auth.models import AbstractBaseUser


class User(AbstractBaseUser):
    email = models.EmailField(
        verbose_name='email address',
        max_length=255,
        unique=True,
    )

    zip_code = models.SmallIntegerField()

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = []


class Adopter(models.Model):

    user = models.ForeignKey(User, on_delete=models.CASCADE)
    availability = models.SmallIntegerField()
    size = models.CharField(max_length=3)
    age = models.CharField(max_length=3)
    traits = models.CharField(max_length=3)

    def __str__(self):
        return self.user.email


class Giver(models.Model):

    user = models.ForeignKey(User, on_delete=models.CASCADE)
    independent = models.BooleanField()
    shelter = models.ForeignKey(Shelter, on_delete=models.CASCADE, null=True, blank=True)

    def __str__(self):
        return self.user.email




