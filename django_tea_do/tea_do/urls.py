from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns
from tea_do import views

urlpatterns = [
    path("list/",views.list, name="list_tea_do"),
    path("create/", views.create, name="create_tea_do"),
    path("update/",views.update,name="update_tea_do"),
    path("remove/",views.remove,name="remove_tea_do")
]

#urlpatterns = format_suffix_patterns(urlpatterns)
