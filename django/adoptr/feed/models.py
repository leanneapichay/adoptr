from django.db import models
from accounts.models import Adopter, Giver
from dogs.models import Dog
from shelters.models import Shelter


# Person and Person
class MatchPP(models.Model):

    dog = models.ForeignKey(Dog, on_delete=models.CASCADE)
    adopter = models.ForeignKey(Adopter, on_delete=models.CASCADE)
    owner = models.ForeignKey(Giver, on_delete=models.CASCADE)
    complete = models.BooleanField(default=False)
    accepted = models.NullBooleanField(null=True, blank=True)

    def __str__(self):
        return self.dog.name + " " + str(self.adopter) + " " + str(self.owner)


# Person and Shelter
class MatchSP(models.Model):

    dog = models.ForeignKey(Dog, on_delete=models.CASCADE)
    adopter = models.ForeignKey(Adopter, on_delete=models.CASCADE)
    shelter = models.ForeignKey(Shelter, on_delete=models.CASCADE)
    complete = models.BooleanField(default=False)
    accepted = models.NullBooleanField(null=True, blank=True)

    def __str__(self):
        return self.dog.name + " " + str(self.adopter) + " " + str(self.shelter)
