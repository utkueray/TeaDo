from rest_framework import serializers
from tea_do.models import TeaDo

class TeaDoSerializer(serializers.ModelSerializer):
    class Meta:
        model = TeaDo
        fields = "__all__"
