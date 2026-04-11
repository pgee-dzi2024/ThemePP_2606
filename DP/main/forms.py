from django import forms


class HandImageUploadForm(forms.Form):
    original_image = forms.ImageField(
        label="Изображение на ръката",
        required=False,
        widget=forms.ClearableFileInput(attrs={
            "accept": "image/*",
            "class": "upload-input",
        }),
    )
    captured_image = forms.CharField(
        required=False,
        widget=forms.HiddenInput(),
    )

    def clean(self):
        cleaned_data = super().clean()
        original_image = cleaned_data.get("original_image")
        captured_image = cleaned_data.get("captured_image")

        if not original_image and not captured_image:
            raise forms.ValidationError("Качи снимка или заснеми снимка от камерата.")
        return cleaned_data