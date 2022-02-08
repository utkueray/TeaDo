from django.shortcuts import render
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from tea_do.serializers import TeaDoSerializer
from tea_do.models import TeaDo
import json
import pyrebase

config = {
    "apiKey": "AIzaSyAq2B7WmmxTlyUuQIk9aC9XzPirxdBXNRI",
    "authDomain": "teado-e6cb4.firebaseapp.com",
    "projectId": "teado-e6cb4",
    "storageBucket": "teado-e6cb4.appspot.com",
    "messagingSenderId": "948596075451",
    "appId": "1:948596075451:web:1672b8b8a17bbe1f62b29e",
    "measurementId": "G-SE1SPN9FXM",
    "databaseURL": "https://teado-e6cb4-default-rtdb.europe-west1.firebasedatabase.app/"
}

firebase = pyrebase.initialize_app(config)
authe = firebase.auth()
database = firebase.database()

def index(request, format=None):
        name = database.child('Data').child('Name').get().val()
        stack = database.child('Data').child('Stack').get().val()
        framework = database.child('Data').child('Framework').get().val()
    
        context = {
            'name':name,
            'stack':stack,
            'framework':framework
        }
        return render(request, 'index.html', context)

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