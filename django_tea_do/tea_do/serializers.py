from rest_framework import serializers
from tea_do.models import *

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = "__all__"

class TeaDoSerializer(serializers.ModelSerializer):
    class Meta:
        model = TeaDo
        fields = "__all__"
