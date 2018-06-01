from rest_framework import serializers
from .models import Dog


class DogSerializer(serializers.ModelSerializer):

    def create(self, validated_data):
        return Dog.objects.create(**validated_data)

    def update(self, instance, validated_data):
        instance.name = validated_data.get('name', instance.name)
        instance.age = validated_data.get('age', instance.age)
        instance.active = validated_data.get('active', instance.active)
        instance.trained = validated_data.get('trained', instance.trained)
        instance.breed = validated_data.get('breed', instance.breed)
        instance.description = validated_data.get('description', instance.description)
        instance.shelter = validated_data.get('shelter', instance.shelter)
        instance.save()
        return instance

    class Meta:
        model = Dog
        fields = '__all__'


