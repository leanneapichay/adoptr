from django.db import models


class Shelter(models.Model):
    name = models.CharField(max_length=200)
    location = models.TextField()
    description = models.TextField()
    zip = models.SmallIntegerField()

    def __str__(self):
        return self.name + ' ' + self.zip


