from django.db import models

class ManicureDesign(models.Model):
    name = models.CharField(max_length=100, verbose_name="Име на дизайна")
    gallery_image = models.ImageField(
        upload_to="designs/gallery/",
        verbose_name="Изображение за галерията",
    )
    simulation_image = models.ImageField(
        upload_to="designs/simulation/",
        verbose_name="Изображение за симулация",
    )
    created_at = models.DateTimeField(auto_now_add=True, verbose_name="Създадено на")

    class Meta:
        verbose_name = "Дизайн за маникюр"
        verbose_name_plural = "Дизайни за маникюр"

    def __str__(self):
        return self.name


class UserSession(models.Model):
    selected_design = models.ForeignKey(
        ManicureDesign,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="user_sessions",
        verbose_name="Избран дизайн"
    )
    original_image = models.ImageField(
        upload_to="uploads/",
        verbose_name="Оригинална снимка"
    )
    processed_image = models.ImageField(
        upload_to="processed/",
        null=True,
        blank=True,
        verbose_name="Обработена снимка"
    )
    uploaded_at = models.DateTimeField(auto_now_add=True, verbose_name="Качено на")

    class Meta:
        verbose_name = "Потребителска сесия"
        verbose_name_plural = "Потребителски сесии"

    def __str__(self):
        return f"Сесия {self.id}"