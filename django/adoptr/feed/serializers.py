from rest_framework import serializers
from .models import MatchPP, MatchSP


class MatchPPSerializer(serializers.ModelSerializer):

    @staticmethod
    def complete_deal(match_obj, accepted):
        match_obj.complete = True
        match_obj.accepted = accepted
        return True

    class Meta:
        model = MatchPP
        fields = '__all__'


class MatchSPSerializer(serializers.ModelSerializer):

    @staticmethod
    def complete_deal(match_obj, accepted):
        match_obj.complete = True
        match_obj.accepted = accepted
        return True

    class Meta:
        model = MatchSP
        fields = '__all__'



