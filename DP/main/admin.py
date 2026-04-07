from django.contrib import admin

# Register your models here.
from django.contrib import admin
from .models import ManicureDesign, UserSession

admin.site.register(ManicureDesign)
admin.site.register(UserSession)