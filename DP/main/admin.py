from django.contrib import admin

from .models import ManicureDesign, UserSession


@admin.register(ManicureDesign)
class ManicureDesignAdmin(admin.ModelAdmin):
    list_display = ("id", "name", "created_at")
    search_fields = ("name",)
    list_filter = ("created_at",)
    ordering = ("-created_at",)


@admin.register(UserSession)
class UserSessionAdmin(admin.ModelAdmin):
    list_display = ("id", "selected_design", "uploaded_at")
    list_filter = ("uploaded_at", "selected_design")
    search_fields = ("id", "selected_design__name")
    ordering = ("-uploaded_at",)