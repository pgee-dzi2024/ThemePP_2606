from django.db import models

# Create your models here.
from django.db import models

class ManicureDesign(models.Model):
    name = models.CharField(max_length=100, verbose_name="Име на дизайна")
    image = models.ImageField(upload_to='designs/', verbose_name="Снимка на цвета/текстурата")
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.name

class UserSession(models.Model):
    original_image = models.ImageField(upload_to='uploads/', verbose_name="Оригинална снимка")
    processed_image = models.ImageField(upload_to='processed/', null=True, blank=True, verbose_name="Обработена снимка")
    uploaded_at = models.DateTimeField(auto_now_add=True)