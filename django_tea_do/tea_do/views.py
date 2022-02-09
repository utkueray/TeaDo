from http import cookies
from django.shortcuts import render
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from tea_do.serializers import *
from tea_do.models import *
import json

@api_view(['GET'])
def users(request):
    if request.method == 'GET':
        if 'uuid' in request.COOKIES:
            uuid = request.COOKIES.get('uuid')
            
            users = User.objects.filter(pk=uuid)
            serializer = UserSerializer(users, many=True)
            return Response(serializer.data)
        return Response(status=status.HTTP_406_NOT_ACCEPTABLE)

@api_view(['POST'])
def createUser(request):
    if request.method == 'POST':
        try:
            body_unicode = request.body.decode('utf-8')
            body = json.loads(body_unicode)
            uuid = body['uuid']
        except TeaDo.DoesNotExist:
            return Response(status=status.HTTP_404_NOT_FOUND)

        serializer = UserSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            response = Response(serializer.data, status=status.HTTP_201_CREATED)
            response.set_cookie('uuid', uuid)
            return response
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET'])
def list(request):
    if request.method == 'GET':
        teaDo = TeaDo.objects.all()
        serializer = TeaDoSerializer(teaDo, many=True)
        return Response(serializer.data)

@api_view(['POST'])
def create(request):
    if request.method == 'POST':
        serializer = TeaDoSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['POST'])
def update(request):
    if request.method == 'POST':
        try:
            body_unicode = request.body.decode('utf-8')
            body = json.loads(body_unicode)
            teaDo_id = body['id']
            teaDo = TeaDo.objects.get(pk=teaDo_id)
        except TeaDo.DoesNotExist:
            return Response(status=status.HTTP_404_NOT_FOUND)

        serializer = TeaDoSerializer(teaDo, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['POST'])
def remove(request):
    if request.method == 'POST':
        try:
            body_unicode = request.body.decode('utf-8')
            body = json.loads(body_unicode)
            teaDo_id = body['id']
            teaDo = TeaDo.objects.get(pk=teaDo_id)
        except TeaDo.DoesNotExist:
            return Response(status=status.HTTP_404_NOT_FOUND)

        teaDo.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)