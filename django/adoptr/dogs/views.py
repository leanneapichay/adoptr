from rest_framework import status
from .models import Dog
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .serializers import DogSerializer


@api_view(['PUT'])
def get_dogs_shelter(request):

    shelter_id = request.data.get('shelter_id')

    try:
        dogs = Dog.objects.filter(shelter_id=shelter_id)
    except Dog.DoesNotExist:
        return Response('Shelter Not Found', status=status.HTTP_404_NOT_FOUND)

    dog_serializer = DogSerializer(dogs, many=True)

    return Response(dog_serializer.data, status=status.HTTP_200_OK)


@api_view(['PUT'])
def get_dog_info(request):

    dog_id = request.data.get('dog_id')

    try:
        dog = Dog.objects.get(id=dog_id)
    except Dog.DoesNotExist:
        return Response('Dog Not Found', status=status.HTTP_404_NOT_FOUND)

    dog_serializer = DogSerializer(dog)
    return Response(dog_serializer.data, status=status.HTTP_200_OK)


@api_view(['POST'])
def create_dog(request):

    serializer = DogSerializer(data=request.data)

    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)

    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['PUT'])
def edit_dog(request):

    dog_id = request.data.get('id')

    try:
        dog = Dog.objects.get(id=dog_id)
    except Dog.DoesNotExist:
        return Response('Dog Not Found', status=status.HTTP_404_NOT_FOUND)

    serializer = DogSerializer(dog, data=request.data)

    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_200_OK)

    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)



