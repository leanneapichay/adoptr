from rest_framework import status
from .serializers import AdopterSerializer, GiverSerializer
from django.contrib.auth.models import User
from rest_framework.authtoken.models import Token
from rest_framework.decorators import api_view
from django.contrib.auth import authenticate
from .models import Adopter, Giver
from rest_framework.permissions import IsAdminUser
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

    pass


@api_view(['POST'])
def signup_giver(request):
    pass

