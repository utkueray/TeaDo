from pickle import TRUE
from django.db import models

class User(models.Model):
    uuid = models.CharField(primary_key=True, max_length=32)
    email = models.EmailField(default="")

    def __str___(self):
        return self.uuid

class TeaDo(models.Model):
    id = models.AutoField(primary_key=True)
    title = models.CharField(max_length = 100)
    body = models.CharField(max_length = 100)
    is_note = models.BooleanField(default=True)
    is_completed = models.BooleanField(default=False)
    date_created = models.DateTimeField(auto_now_add = True, auto_now = False)
    last_modified = models.DateTimeField(auto_now=True)
    
    def __str___(self):
        return self.id