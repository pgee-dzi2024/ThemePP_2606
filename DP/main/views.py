from pathlib import Path
import base64
import logging
import uuid

from django.conf import settings
from django.core.files.base import ContentFile


from django.shortcuts import get_object_or_404, render, redirect
from django.urls import reverse

from .forms import HandImageUploadForm
from .models import ManicureDesign, UserSession
from .utils import apply_design_overlay, is_mediapipe_available

logger = logging.getLogger(__name__)


def _file_from_data_url(data_url: str):
    """
    Преобразува data URL (base64) към Django ContentFile.
    """
    if not data_url or "," not in data_url:
        return None

    try:
        header, encoded = data_url.split(",", 1)
        if "image/" not in header:
            return None
        ext = "png"
        if "image/jpeg" in header or "image/jpg" in header:
            ext = "jpg"

        decoded = base64.b64decode(encoded)
        file_name = f"camera_{uuid.uuid4().hex}.{ext}"
        return ContentFile(decoded, name=file_name)
    except Exception:
        return None

def index(request):
    designs = ManicureDesign.objects.all().order_by("-created_at")
    return render(request, "main/index.html", {"designs": designs})

def design_detail(request, design_id):
    design = get_object_or_404(ManicureDesign, pk=design_id)
    form = HandImageUploadForm()
    return render(request, "main/design_detail.html", {"design": design, "form": form})


def upload_hand_image(request, design_id):
    design = get_object_or_404(ManicureDesign, pk=design_id)

    if request.method == "POST":
        form = HandImageUploadForm(request.POST, request.FILES)
        if form.is_valid():
            camera_file = _file_from_data_url(form.cleaned_data.get("captured_image"))
            source_image = camera_file if camera_file else form.cleaned_data.get("original_image")

            user_session = UserSession.objects.create(
                selected_design=design,
                original_image=source_image,
            )

            input_hand_path = user_session.original_image.path
            input_design_path = design.simulation_image.path

            if is_mediapipe_available():
                try:
                    from .utils import detect_hand_landmarks_and_nails
                    landmark_result = detect_hand_landmarks_and_nails(
                        input_hand_path,
                        output_path=None,
                    )
                    if not landmark_result.get("found"):
                        user_session.delete()
                        form.add_error(
                            "original_image",
                            "Снимката не е достатъчно подходяща. Моля, опитай с по-ясна снимка на ръката."
                        )
                        return render(
                            request,
                            "main/design_detail.html",
                            {"design": design, "form": form},
                        )
                except Exception as exc:
                    logger.info("Landmarks проверката не успя: %s", exc)

            output_filename = f"session_{user_session.id}_processed.jpg"
            output_path = Path(settings.MEDIA_ROOT) / "processed" / output_filename

            try:
                apply_design_overlay(
                    hand_image_path=input_hand_path,
                    design_image_path=input_design_path,
                    output_path=output_path,
                )

                user_session.processed_image.name = f"processed/{output_filename}"
                user_session.save(update_fields=["processed_image"])

                return redirect(reverse("main:result", kwargs={"session_id": user_session.id}))
            except Exception as exc:
                logger.exception("Грешка при обработката на изображението: %s", exc)
                form.add_error(None, "Възникна проблем при обработката на изображението.")
                user_session.delete()
                return render(request, "main/design_detail.html", {"design": design, "form": form})
    else:
        form = HandImageUploadForm()

    return render(
        request,
        "main/design_detail.html",
        {"design": design, "form": form}
    )


def result(request, session_id):
    user_session = get_object_or_404(UserSession, pk=session_id)
    return render(request, "main/result.html", {"session": user_session})