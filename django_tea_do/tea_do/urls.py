from django.urls import path
from tea_do import views

urlpatterns = [
    path("list/",views.ListAPIView.as_view(),name="list_tea_do"),
    path("create/", views.CreateAPIView.as_view(),name="create_tea_do"),
    path("update/<int:pk>/",views.UpdateAPIView.as_view(),name="update_tea_do"),
    path("delete/<int:pk>/",views.DeleteAPIView.as_view(),name="delete_tea_do")
]