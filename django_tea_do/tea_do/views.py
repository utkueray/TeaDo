import json
from multiprocessing.dummy import Array
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from tea_do.serializers import TeaDoSerializer
from tea_do.models import TeaDo

# List Request, returns all the objects with the given user's device uuid.
@api_view(['POST'])
def list(request):
    if request.method == 'POST':
        try:
            body_unicode = request.body.decode('utf-8')
            body = json.loads(body_unicode)
            uuidBody = body['uuid']
            teaDo = TeaDo.objects.filter(uuid = uuidBody)
            queryset = teaDo.order_by('-last_modified')
        except TeaDo.DoesNotExist:
            return Response({'data', []}, status=status.HTTP_404_NOT_FOUND)
        
        if teaDo is not None:
            serializer = TeaDoSerializer(queryset, many=True)
            return Response({'data': serializer.data}, status=status.HTTP_200_OK)
    return Response({'data', []}, status=status.HTTP_400_BAD_REQUEST)

# Creat Request, creates a new object in the database.
@api_view(['POST'])
def create(request):
    if request.method == 'POST':       
        serializer = TeaDoSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response({'data': [serializer.data]}, status=status.HTTP_201_CREATED)
        return Response({'data', []}, status=status.HTTP_400_BAD_REQUEST)
        
# Update Request, updates the object with the given id which is the primary key
@api_view(['POST'])
def update(request):
    if request.method == 'POST':
        try:
            body_unicode = request.body.decode('utf-8')
            body = json.loads(body_unicode)
            teaDo_id = body['id']
            teaDo = TeaDo.objects.get(pk=teaDo_id)
        except TeaDo.DoesNotExist:
            return Response({'data', []}, status=status.HTTP_404_NOT_FOUND)

        serializer = TeaDoSerializer(teaDo, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response({'data': [serializer.data]}, status=status.HTTP_200_OK)
        return Response({'data', []}, status=status.HTTP_400_BAD_REQUEST)

# Remove Request, removed the object with the given id
@api_view(['POST'])
def remove(request):
    if request.method == 'POST':
        try:
            body_unicode = request.body.decode('utf-8')
            body = json.loads(body_unicode)
            teaDo_id = body['id']
            teaDo = TeaDo.objects.get(pk=teaDo_id)
        except TeaDo.DoesNotExist:
            return Response({'data': {'deleted':False}}, status=status.HTTP_404_NOT_FOUND)

        teaDo.delete()
        return Response({'data': 
        {'id':teaDo_id,
        'deleted':True}}, status=status.HTTP_200_OK)