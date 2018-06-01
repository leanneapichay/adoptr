from rest_framework import status
from .models import Dog
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .serializers import DogSerializer
from rest_framework.renderers import JSONRenderer
from rest_framework.parsers import JSONParser


@api_view(['GET'])
def get_dogs_shelter(request):

    shelter_id = request.data.get('shelter_id')

    try:
        dogs = Dog.objects.filter(shelter_id=shelter_id)
    except Dog.DoesNotExist:
        return Response('Shelter Not Found', status=status.HTTP_404_NOT_FOUND)

    dog_serializer = DogSerializer(dogs, many=True)
    json_dog = JSONRenderer().render(dog_serializer.data)

    return Response(json_dog, status=status.HTTP_200_OK)


@api_view(['GET'])
def get_dog_info(request):

    dog_id = request.data.get('dog_id')

    try:
        dog = Dog.objects.get(id=dog_id)
    except Dog.DoesNotExist:
        return Response('Dog Not Found', status=status.HTTP_404_NOT_FOUND)

    dog_serializer = DogSerializer(dog)
    json_dog = JSONRenderer().render(dog_serializer.data)

    return Response(json_dog, status=status.HTTP_200_OK)


@api_view(['POST'])
def create_dog(request):

    name = request.data.get('name')
    age = request.data.get('age')
    des = request.data.get('description')
    active = request.data.get('active')
    trained = request.data.get('trained')
    breed = request.data.get('breed')
    shelter = request.data.get('shelter_id')

    serializer = DogSerializer(data=request.data)

    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)

    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)



