from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework import status
from accounts.models import Adopter, User
from .models import MatchPP, MatchSP
from .serializers import MatchPPSerializer, MatchSPSerializer
from dogs.models import Dog
from dogs.serializers import DogSerializer
from django.db.models import Q
from .feed_algorithm import get_query


@api_view(['GET'])
def feed(request):

    email = request.data.get('email')  # can change to tokens
    num = request.data.get('num')

    # Can use nosql db to get list of declined dogs for each user so that feed can remember

    try:
        user = User.objects.get(email=email)
    except User.DoesNotExist:
        return Response('User Not Found', status=status.HTTP_404_NOT_FOUND)

    try:
        adopter = Adopter.objects.get(user_id=user.id)
    except Adopter.DoesNotExist:
        return Response('Adopter Not Found', status=status.HTTP_404_NOT_FOUND)

    adopter_age_range = adopter.age
    adopter_size = adopter.size
    adopter_traits = adopter.traits

    characteristics = adopter_traits + adopter_size + adopter_age_range
    char_list = []  # list of characteristics

    for i in characteristics:
        if i == '1':
            char_list.append(True)
        elif i == '0':
            char_list.append(False)

    query = get_query(char_list=char_list)

    dogs = Dog.objects.filter(query)

    dog_serializer = DogSerializer(dogs, many=True)

    return Response(dog_serializer.data, status=status.HTTP_200_OK)



@api_view(['GET'])
def get_non_completed_matches(request):

    adopter_email = request.data.get('email')

    try:
        user = User.objects.get(email=adopter_email)
    except User.DoesNotExist:
        return Response('User Not Found', status=status.HTTP_404_NOT_FOUND)

    try:
        adopter = Adopter.objects.get(user_id=user.id)
    except Adopter.DoesNotExist:
        return Response('Adopter Not Found', status=status.HTTP_404_NOT_FOUND)

    matches_pp = MatchPP.objects.filter(adopter_id=adopter.id, complete=False)
    matches_sp = MatchSP.objects.filter(adopter_id=adopter.id, complete=False)

    match_pp_serializer = MatchPPSerializer(matches_pp, many=True)
    match_sp_serializer = MatchSPSerializer(matches_sp, many=True)

    return Response({'People': match_pp_serializer.data, 'Shelters': match_sp_serializer.data})


@api_view(['GET'])
def get_completed_matches(request):

    adopter_email = request.data.get('email')

    try:
        user = User.objects.get(email=adopter_email)
    except User.DoesNotExist:
        return Response('User Not Found', status=status.HTTP_404_NOT_FOUND)

    try:
        adopter = Adopter.objects.get(user_id=user.id)
    except Adopter.DoesNotExist:
        return Response('Adopter Not Found', status=status.HTTP_404_NOT_FOUND)

    accepted_deals_pp = MatchPP.objects.filter(adopter_id=adopter.id, complete=True)

    accepted_deals_sp = MatchSP.objects.filter(adopter_id=adopter.id, complete=True)

    match_pp_serializer = MatchPPSerializer(accepted_deals_pp, many=True)
    match_sp_serializer = MatchSPSerializer(accepted_deals_sp, many=True)

    return Response({'People': match_pp_serializer.data, 'Shelters': match_sp_serializer.data},
                    status=status.HTTP_200_OK)


@api_view(['GET'])
def accept_match_giver(request):

    match_id = request.data.get('match-id')

    try:
        match = MatchPP.objects.get(id=match_id)
    except MatchPP.DoesNotExist:
        return Response('Match Not Found', status=status.HTTP_404_NOT_FOUND)

    if MatchPPSerializer.complete_deal(match_obj=match, accepted=True):
        return Response('Success', status=status.HTTP_200_OK)

    return Response('Something Went Wrong', status=status.HTTP_400_BAD_REQUEST)



