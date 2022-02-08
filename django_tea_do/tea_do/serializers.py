from rest_framework import serializers
from tea_do.models import *

class TeaDoSerializer(serializers.ModelSerializer):
    class Meta:
        model = TeaDo
        fields = "__all__"

class InitSerializer(serializers.ModelSerializer):
    class Meta:
        model = Init
        fields = "__all__"