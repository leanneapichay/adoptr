from rest_framework import serializers
from .models import Shelter


class ShelterSerializer(serializers.ModelSerializer):

    def create(self, validated_data):
        return Shelter.objects.create(**validated_data)

    def update(self, instance, validated_data):
        instance.name = validated_data.get('name', instance.name)
        instance.location = validated_data.get('location', instance.location)
        instance.description = validated_data.get('description', instance.description)
        instance.zip = validated_data.get('zip', instance.zip)

    class Meta:
        model = Shelter
        fields = '__all__'

