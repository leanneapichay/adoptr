from rest_framework import serializers
from .models import Dog


class Dog(serializers.ModelSerializer):

    class Meta:
        model = Dog
        fields = '__all__'


