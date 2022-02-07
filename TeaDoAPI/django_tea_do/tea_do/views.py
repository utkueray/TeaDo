from django.shortcuts import render
from rest_framework.generics import ListAPIView
from rest_framework.generics import CreateAPIView
from rest_framework.generics import DestroyAPIView
from rest_framework.generics import UpdateAPIView
from tea_do.serializers import TeaDoSerializer
from tea_do.models import TeaDo

# Create your views here.
class ListAPIView(ListAPIView):
    """This endpoint list all of the available todos from the database"""
    queryset = TeaDo.objects.all()
    serializer_class = TeaDoSerializer

class CreateAPIView(CreateAPIView):
    """This endpoint allows for creation of a todo"""
    queryset = TeaDo.objects.all()
    serializer_class = TeaDoSerializer

class UpdateAPIView(UpdateAPIView):
    """This endpoint allows for updating a specific todo by passing in the id of the todo to update"""
    queryset = TeaDo.objects.all()
    serializer_class = TeaDoSerializer

class DeleteAPIView(DestroyAPIView):
    """This endpoint allows for deletion of a specific Todo from the database"""
    queryset = TeaDo.objects.all()
    serializer_class = TeaDoSerializer