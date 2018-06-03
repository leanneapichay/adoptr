from rest_framework import status
from .models import Shelter
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .serializers import ShelterSerializer


@api_view(['PUT'])
def get_zip_shelters(request):

    zip_code = request.data.get('zip')

    try:
        shelters = Shelter.objects.filter(zip=zip_code)
    except Shelter.DoesNotExist:
        return Response('Not Shelters in that Zip', status=status.HTTP_404_NOT_FOUND)

    shelter_serializer = ShelterSerializer(shelters, many=True)

    return Response(shelter_serializer.data, status=status.HTTP_200_OK)


@api_view(['PUT'])
def get_shelter(request):

    shelter_id = request.data.get('shelter_id')

    try:
        shelter = Shelter.objects.get(id=shelter_id)
    except Shelter.DoesNotExist:
        return Response('Shelter Not Found', status=status.HTTP_404_NOT_FOUND)

    shelter_serializer = ShelterSerializer(shelter)

    return Response(shelter_serializer.data, status=status.HTTP_200_OK)


