from django.urls import path

from . import views

app_name = "main"

urlpatterns = [
    path("", views.index, name="index"),
    path("design/<int:design_id>/", views.design_detail, name="design_detail"),
    path("design/<int:design_id>/upload/", views.upload_hand_image, name="upload_hand_image"),
    path("result/<int:session_id>/", views.result, name="result"),
]
