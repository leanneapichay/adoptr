from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework import status
from accounts.models import Adopter, User
from .models import MatchPP, MatchSP
from .serializers import MatchPPSerializer, MatchSPSerializer


@api_view(['GET'])
def feed(request):

    email = request.data.get('email')  # can change to tokens
    num = request.data.get('num')

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



@api_view(['GET'])
def get_matches(request):

    adopter_email = request.data.get('adopter-email')


@api_view(['GET'])
def get_complete_matches(request):

    adopter_email = request.data.get('adopter-email')

    try:
        user = User.objects.get(email=adopter_email)
    except User.DoesNotExist:
        return Response('User Not Found', status=status.HTTP_404_NOT_FOUND)

    try:
        adopter = Adopter.objects.get(user_id=user.id)
    except Adopter.DoesNotExist:
        return Response('Adopter Not Found', status=status.HTTP_404_NOT_FOUND)

    accepted_deals_pp = MatchPP.objects.filter(adopter=adopter.id, complete=True)

    accepted_deals_sp = MatchSP.objects.filter(adopter=adopter.id, complete=True)

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



