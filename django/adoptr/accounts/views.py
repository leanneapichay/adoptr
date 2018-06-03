from rest_framework import status
from .serializers import AdopterSerializer, GiverSerializer, UserSerializer
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .authentication import AuthBackend
from .models import User, Adopter, Giver


@api_view(['POST'])
def login(request):

    email = request.data.get('email')
    password = request.data.get('password')

    user = AuthBackend.authenticate(email=email, password=password)

    if not user:
        return Response('Wong Username or Password', status=status.HTTP_401_UNAUTHORIZED)

    user_serializer = UserSerializer(user)

    return Response(user_serializer.data, status=status.HTTP_200_OK)


@api_view(['POST'])
def signup_adopter(request):

    user = User.objects.create_user(email=request.data.get('email'), password=request.data.get('password'))

    user_serializer = UserSerializer(user)

    if user:
        appended_data = request.data
        appended_data['user'] = user.id  # append user id onto the request.data dictionary
        a_serializer = AdopterSerializer(data=appended_data)

        if a_serializer.is_valid():
            a_serializer.save()

            return Response({'User Data': user_serializer.data, 'Adopter Data': a_serializer.data},
                            status=status.HTTP_201_CREATED)

        return Response(a_serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    return Response('Something Went Wrong', status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def signup_giver(request):

    user = User.objects.create_user(email=request.data.get('email'), password=request.data.get('password'))

    user_serializer = UserSerializer(user)

    if user:
        appended_data = request.data
        appended_data['user'] = user.id  # append user id onto the request.data dictionary
        g_serializer = GiverSerializer(data=appended_data)

        if g_serializer.is_valid():
            g_serializer.save()

            return Response({'User Data': user_serializer.data, 'Giver Data': g_serializer.data},
                            status=status.HTTP_201_CREATED)

        return Response(g_serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    return Response('Something Went Wrong', status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET'])
def get_adopter_info(request):

    email = request.data.get('email')

    try:
        user = User.objects.get(email=email)
    except User.DoesNotExist:
        return Response('User Not Found', status=status.HTTP_404_NOT_FOUND)

    try:
        adopter = Adopter.objects.get(user_id=user.id)
    except Adopter.DoesNotExist:
        return Response('Adopter Not Found', status=status.HTTP_404_NOT_FOUND)

    user_serializer = UserSerializer(user)
    adopter_serializer = AdopterSerializer(adopter)

    return Response({'User Data': user_serializer.data, 'Adopter Data': adopter_serializer.data},
                    status=status.HTTP_200_OK)


@api_view(['GET'])
def get_giver_info(request):

    email = request.data.get('email')

    try:
        user = User.objects.get(email=email)
    except User.DoesNotExist:
        return Response('User Not Found', status=status.HTTP_404_NOT_FOUND)

    try:
        giver = Giver.objects.get(user_id=user.id)
    except Giver.DoesNotExist:
        return Response('Adopter Not Found', status=status.HTTP_404_NOT_FOUND)

    user_serializer = UserSerializer(user)
    giver_serializer = GiverSerializer(giver)

    return Response({'User Data': user_serializer.data, 'Giver Data': giver_serializer.data},
                    status=status.HTTP_200_OK)


@api_view(['GET'])
def get_account_type(request):

    email = request.data.get('email')

    try:
        user = User.objects.get(email=email)
    except User.DoesNotExist:
        return Response('User Not Found', status=status.HTTP_404_NOT_FOUND)

    try:
        Adopter.objects.get(user_id=user.id)
        return Response('Adopter', status=status.HTTP_200_OK)
    except Adopter.DoesNotExist:
        try:
            Giver.objects.get(user_id=user.id)
            return Response('Giver', status=status.HTTP_200_OK)
        except Giver.DoesNotExist:
            return Response('Account Not Found', status=status.HTTP_404_NOT_FOUND)


