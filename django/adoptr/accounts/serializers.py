from rest_framework import serializers
from .models import Giver, Adopter


class AdopterSerializer(serializers.ModelSerializer):

    class Meta:
        model = Adopter
        fields = '__all__'


class GiverSerializer(serializers.ModelSerializer):

    class Meta:
        model = Giver
        fields = '__all_-'
