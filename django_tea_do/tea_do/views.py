import json
from multiprocessing.dummy import Array
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from tea_do.serializers import TeaDoSerializer
from tea_do.models import TeaDo

@api_view(['POST'])
def list(request):
    if request.method == 'POST':
        try:
            body_unicode = request.body.decode('utf-8')
            body = json.loads(body_unicode)
            uuidBody = body['uuid']
            teaDo = TeaDo.objects.filter(uuid = uuidBody)
        except TeaDo.DoesNotExist:
            return Response({'data', {}}, status=status.HTTP_404_NOT_FOUND)
        
        if teaDo is not None:
            serializer = TeaDoSerializer(teaDo, many=True)
            return Response({'data': serializer.data}, status=status.HTTP_200_OK)
    return Response({'data', {}}, status=status.HTTP_400_BAD_REQUEST)

@api_view(['POST'])
def create(request):
    if request.method == 'POST':       
        serializer = TeaDoSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response({'data': serializer.data}, status=status.HTTP_201_CREATED)
        return Response({'data', {}}, status=status.HTTP_400_BAD_REQUEST)
        

@api_view(['POST'])
def update(request):
    if request.method == 'POST':
        try:
            body_unicode = request.body.decode('utf-8')
            body = json.loads(body_unicode)
            teaDo_id = body['id']
            teaDo = TeaDo.objects.get(pk=teaDo_id)
        except TeaDo.DoesNotExist:
            return Response({'data', {}}, status=status.HTTP_404_NOT_FOUND)

        serializer = TeaDoSerializer(teaDo, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response({'data': serializer.data}, status=status.HTTP_200_OK)
        return Response({'data', {}}, status=status.HTTP_400_BAD_REQUEST)

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