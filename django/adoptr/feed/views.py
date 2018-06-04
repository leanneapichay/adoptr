from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework import status
from accounts.models import Adopter, User, Giver
from .models import MatchPP, MatchSP
from .serializers import MatchPPSerializer, MatchSPSerializer
from dogs.models import Dog
from dogs.serializers import DogSerializer
from .feed_algorithm import get_query


@api_view(['PUT'])
def feed(request):

    email = request.data.get('email')  # can change to tokens
    num = request.data.get('num')

    # Can create new table to keep track of yes's and no's in a server w/ 2 FK's

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

    dogs = Dog.objects.filter(query)[int(num) * 5:(int(num) * 5) + 5]

    dog_serializer = DogSerializer(dogs, many=True)

    return Response(dog_serializer.data, status=status.HTTP_200_OK)


@api_view(['POST'])
def create_match_pp(request):

    adopter_email = request.data.get('email')  # can use tokens

    try:
        user = User.objects.get(email=adopter_email)
    except User.DoesNotExist:
        return Response('User Not Found', status=status.HTTP_404_NOT_FOUND)

    try:
        adopter = Adopter.objects.get(user_id=user.id)
    except Adopter.DoesNotExist:
        return Response('Adopter Not Found', status=status.HTTP_404_NOT_FOUND)

    appended_data = request.data
    appended_data['adopter'] = adopter.id

    serializer = MatchPPSerializer(data=appended_data)

    if serializer.is_valid():
        serializer.save()

        return Response(serializer.data, status=status.HTTP_200_OK)

    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


# for adopters and givers, not shelters
@api_view(['PUT'])
def get_non_completed_matches(request):

    email = request.data.get('email')

    try:
        user = User.objects.get(email=email)
    except User.DoesNotExist:
        return Response('User Not Found', status=status.HTTP_404_NOT_FOUND)

    try:
        adopter = Adopter.objects.get(user_id=user.id)
        is_adopter = True
    except Adopter.DoesNotExist:
        try:
            giver = Giver.objects.get(user_id=user.id)
            is_adopter = False
        except Giver.DoesNotExist:
            return Response('User Not Found', status=status.HTTP_404_NOT_FOUND)

    if is_adopter is True:
        matches_pp = MatchPP.objects.filter(adopter_id=adopter.id, complete=False)
        matches_sp = MatchSP.objects.filter(adopter_id=adopter.id, complete=False)
        match_pp_serializer = MatchPPSerializer(matches_pp, many=True)
        match_sp_serializer = MatchSPSerializer(matches_sp, many=True)
        return Response({'People': match_pp_serializer.data, 'Shelters': match_sp_serializer.data},
                        status=status.HTTP_200_OK)
    else:
        match_pp = MatchPP.objects.filter(owner_id=giver.id, complete=False)
        match_pp_serializer = MatchPPSerializer(match_pp, many=True)
        return Response(match_pp_serializer.data, status=status.HTTP_200_OK)


@api_view(['PUT'])
def get_completed_matches(request):

    email = request.data.get('email')

    try:
        user = User.objects.get(email=email)
    except User.DoesNotExist:
        return Response('User Not Found', status=status.HTTP_404_NOT_FOUND)

    try:
        adopter = Adopter.objects.get(user_id=user.id)
        is_adopter = True
    except Adopter.DoesNotExist:
        try:
            giver = Giver.objects.get(user_id=user.id)
            is_adopter = False
        except Giver.DoesNotExist:
            return Response('User Not Found', status=status.HTTP_404_NOT_FOUND)

    if is_adopter is True:
        matches_pp = MatchPP.objects.filter(adopter_id=adopter.id, complete=True)
        matches_sp = MatchSP.objects.filter(adopter_id=adopter.id, complete=True)
        match_pp_serializer = MatchPPSerializer(matches_pp, many=True)
        match_sp_serializer = MatchSPSerializer(matches_sp, many=True)
        return Response({'People': match_pp_serializer.data, 'Shelters': match_sp_serializer.data},
                        status=status.HTTP_200_OK)
    else:
        match_pp = MatchPP.objects.filter(owner_id=giver.id, complete=True)
        match_pp_serializer = MatchPPSerializer(match_pp, many=True)
        return Response(match_pp_serializer.data, status=status.HTTP_200_OK)


@api_view(['PUT'])
def complete_match_giver(request):

    match_id = request.data.get('match-id')
    accepted = request.data.get('accepted')

    try:
        match = MatchPP.objects.get(id=match_id)
    except MatchPP.DoesNotExist:
        return Response('Match Not Found', status=status.HTTP_404_NOT_FOUND)

    if MatchPPSerializer.complete_deal(match_obj=match, accepted=accepted):
        return Response('Success', status=status.HTTP_200_OK)

    return Response('Something Went Wrong', status=status.HTTP_400_BAD_REQUEST)



