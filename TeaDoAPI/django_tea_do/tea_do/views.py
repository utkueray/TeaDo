from django.shortcuts import render
from rest_framework.generics import ListAPIView
from rest_framework.generics import CreateAPIView
from rest_framework.generics import DestroyAPIView
from rest_framework.generics import UpdateAPIView
from tea_do.serializers import TeaDoSerializer
from tea_do.models import TeaDo
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

def index(request):
        #accessing our firebase data and storing it in a variable
        name = database.child('Data').child('Name').get().val()
        stack = database.child('Data').child('Stack').get().val()
        framework = database.child('Data').child('Framework').get().val()
    
        context = {
            'name':name,
            'stack':stack,
            'framework':framework
        }
        return render(request, 'index.html', context)

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