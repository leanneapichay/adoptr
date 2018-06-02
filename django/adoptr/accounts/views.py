from rest_framework import status
from .serializers import AdopterSerializer, GiverSerializer
from django.contrib.auth.models import User
from rest_framework.authtoken.models import Token
from rest_framework.decorators import api_view
from django.contrib.auth import authenticate
from .models import Adopter, Giver
from rest_framework.response import Response


@api_view(['GET'])
def login(request):

    email = request.data.get('email')
    password = request.data.get('password')

    user = authenticate(email=email, password=password)  # Make custom auth

    if not user:
        return Response('Wong Username or Password', status=status.HTTP_401_UNAUTHORIZED)

    token, _ = Token.objects.get_or_create(user_id=user.id)

    return Response({"token": token.key, "id": user.id}, status=status.HTTP_200_OK)


@api_view(['POST'])
def signup_adopter(request):

    email = request.data.get('email')
    password = request.data.get('password')
    first_name = request.data.get('first_name')
    last_name = request.data.get('last_name')
    zip_code = request.data.get('zip_code')
    num_pets = request.data.get('num_pets')
    birth_date = request.data.get('birth_date')
    dog_size = request.data.get('dog_size')
    dog_age = request.data.get('dog_age')
    dog_traits = request.data.get('dog_traits')

    user_data = [email, password, first_name, last_name]
    adopter_data = [zip_code, num_pets, birth_date, dog_size, dog_age, dog_traits]

    serializer = AdopterSerializer(data=user_data)
    a_serializer = AdopterSerializer(data=adopter_data)

    # Change this in the future

    # Create new user and then use it as the foreign key in order to create a new account

    return Response({'User Data': serializer.data, 'Adopter Data': a_serializer.data})





@api_view(['POST'])
def signup_giver(request):
    pass


