from django.db import models
from shelters.models import Shelter
from django.contrib.auth.models import AbstractBaseUser
from django.contrib.auth.models import BaseUserManager


class UserManager(BaseUserManager):

    def create_user(self, email, password):
        if not email:
            raise ValueError('Users Must Have An Email Address')

        user = self.model(
            email=self.normalize_email(email),
        )

        user.set_password(password)
        user.save()
        return user

    def create_staff_user(self, email, password):

        user = self.create_user(
            email,
            password=password,
        )
        user.is_staff = True
        user.save(using=self._db)
        return user

    def create_superuser(self, email, password):

        user = self.create_user(
            email,
            password=password,
        )
        user.is_staff = True
        user.is_superuser = True
        user.save(using=self._db)
        return user


class User(AbstractBaseUser):
    email = models.EmailField(
        verbose_name='email address',
        max_length=255,
        unique=True,
    )

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = []

    active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)
    is_superuser = models.BooleanField(default=False)

    objects = UserManager()

    def has_perm(self, perm, obj=None):
        return self.is_superuser

    def has_module_perms(self, app_label):
        return self.is_superuser


class Adopter(models.Model):

    user = models.ForeignKey(User, on_delete=models.CASCADE)
    first_name = models.CharField(max_length=30)
    last_name = models.CharField(max_length=30)
    zip_code = models.SmallIntegerField()
    availability = models.SmallIntegerField()
    size = models.CharField(max_length=3)
    age = models.CharField(max_length=3)
    traits = models.CharField(max_length=3)
    num_pets = models.SmallIntegerField()

    def __str__(self):
        return self.age


class Giver(models.Model):

    user = models.ForeignKey(User, on_delete=models.CASCADE)
    first_name = models.CharField(max_length=30)
    last_name = models.CharField(max_length=30)
    independent = models.BooleanField()
    zip_code = models.SmallIntegerField()
    shelter = models.ForeignKey(Shelter, on_delete=models.CASCADE, null=True, blank=True)

    def __str__(self):
        return self.independent




