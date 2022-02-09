from django.urls import path
from tea_do import views

urlpatterns = [
    path("users/",       views.users,       name="users_tea_do"),
    path("createuser/",  views.createUser,  name="create_user_tea_do"),
    path("list/",        views.list,        name="list_tea_do"),
    path("create/",      views.create,      name="create_tea_do"),
    path("update/",      views.update,      name="update_tea_do"),
    path("remove/",      views.remove,      name="remove_tea_do")
]
