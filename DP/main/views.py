from django.shortcuts import render

def index(request):
    return render(request, 'main/index.html')


from django.shortcuts import render, get_object_or_404
from .models import ManicureDesign, UserSession


def index(request):
    # Вземаме всички дизайни от базата данни за галерията
    designs = ManicureDesign.objects.all()
    return render(request, 'main/index.html', {'designs': designs})


def apply_manicure(request, design_id):
    design = get_object_or_404(ManicureDesign, id=design_id)

    if request.method == 'POST' and request.FILES.get('hand_image'):
        # 1. Запазваме качената снимка на ръка
        session = UserSession.objects.create(
            original_image=request.FILES['hand_image']
        )

        # 2. Тук по-късно ще извикаме OpenCV/MediaPipe скрипта
        # Засега само ще подадем обектите към шаблона
        return render(request, 'main/result.html', {
            'design': design,
            'session': session
        })

    return render(request, 'main/upload_hand.html', {'design': design})