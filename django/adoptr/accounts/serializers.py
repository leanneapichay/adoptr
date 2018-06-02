from rest_framework import serializers
from .models import Giver, Adopter, User


class AdopterSerializer(serializers.ModelSerializer):

    class Meta:
        model = Adopter
        fields = '__all__'


class GiverSerializer(serializers.ModelSerializer):

    class Meta:
        model = Giver
        fields = '__all__'


class UserSerializer(serializers.Serializer):

    email = serializers.EmailField()

    def create(self, validated_data):
        user = User.objects.create_user(email=validated_data.get('email'),
                                        password=validated_data.get('password'))

        return user

    def update(self, instance, validated_data):
        # Can implement later
        pass

