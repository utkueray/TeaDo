from pickle import TRUE
from django.db import models

class TeaDo(models.Model):
    id = models.AutoField(primary_key=True)
    title = models.CharField(max_length = 100, null=True)
    body = models.CharField(max_length = 100, null=True)
    is_note = models.BooleanField(default=True)
    is_completed = models.BooleanField(default=False)
    date_created = models.DateTimeField(auto_now_add = True, auto_now = False)
    last_modified = models.DateTimeField(auto_now=True)
    uuid = models.CharField(max_length=36)

    def __str___(self):
        return self.id