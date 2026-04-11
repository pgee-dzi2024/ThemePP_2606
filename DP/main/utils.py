from pathlib import Path
import math
import logging

import cv2
import numpy as np
from PIL import Image, ImageEnhance

try:
    import mediapipe as mp
except Exception:
    mp = None


logger = logging.getLogger(__name__)

FINGER_TIPS = {
    "thumb": 4,
    "index": 8,
    "middle": 12,
    "ring": 16,
    "pinky": 20,
}

FINGER_DIPS = {
    "thumb": 3,
    "index": 7,
    "middle": 11,
    "ring": 15,
    "pinky": 19,
}

FINGER_BASES = {
    "thumb": 2,
    "index": 5,
    "middle": 9,
    "ring": 13,
    "pinky": 17,
}

FINGER_OVERLAY_RULES = {
    "thumb": {
        "width_multiplier": 0.92,
        "height_multiplier": 0.78,
        "center_x_shift": -2,
        "center_y_shift": -4,
        "angle_shift": -12,
        "angle_min": -155,
        "angle_max": -20,
    },
    "index": {
        "width_multiplier": 2,
        "height_multiplier": 0.76,
        "center_x_shift": 0,
        "center_y_shift": -3,
        "angle_shift": 0,
        "angle_min": -120,
        "angle_max": 20,
    },
    "middle": {
        "width_multiplier": 0.90,
        "height_multiplier": 0.78,
        "center_x_shift": 0,
        "center_y_shift": -3,
        "angle_shift": 0,
        "angle_min": -120,
        "angle_max": 20,
    },
    "ring": {
        "width_multiplier": 0.88,
        "height_multiplier": 0.76,
        "center_x_shift": 0,
        "center_y_shift": -3,
        "angle_shift": 2,
        "angle_min": -120,
        "angle_max": 30,
    },
    "pinky": {
        "width_multiplier": 0.82,
        "height_multiplier": 0.72,
        "center_x_shift": 1,
        "center_y_shift": -4,
        "angle_shift": -10,
        "angle_min": -110,
        "angle_max": 35,
    },
}

# Спрайтът е „легнал“ на 90° спрямо нокътната ос в текущите ти примери.
SPRITE_BASE_ANGLE_OFFSET = 90

# Глобален скейл за всички нокти (1.0 = без промяна)
GLOBAL_NAIL_WIDTH_SCALE = 2.15
GLOBAL_NAIL_HEIGHT_SCALE = 1.50
GLOBAL_NAIL_Y_SHIFT = -6  # отрицателно = нагоре


def _resize_image_to_fit(image, target_width, target_height):
    """
    Оразмерява изображението така, че да се събере в target box
    при запазване на пропорциите.
    """
    target_width = max(1, int(target_width))
    target_height = max(1, int(target_height))

    scale_w = target_width / image.width
    scale_h = target_height / image.height
    scale = min(scale_w, scale_h)

    new_w = max(1, int(image.width * scale))
    new_h = max(1, int(image.height * scale))

    return image.resize((new_w, new_h), Image.Resampling.LANCZOS)


def is_mediapipe_available():
    if mp is None:
        return False

    try:
        _get_mediapipe_solutions()
        return True
    except ImportError:
        return False


def _get_mediapipe_solutions():
    if mp is None:
        raise ImportError("MediaPipe не е наличен.")

    try:
        return mp.solutions.hands, mp.solutions.drawing_utils
    except Exception as exc:
        raise ImportError("Не може да се зареди MediaPipe Hands API.") from exc


def _load_image_rgb(image_path):
    with Image.open(image_path) as img:
        return np.array(img.convert("RGB"))


def _preprocess_for_mediapipe(image_rgb):
    pil_image = Image.fromarray(image_rgb)
    pil_image = ImageEnhance.Contrast(pil_image).enhance(1.25)
    pil_image = ImageEnhance.Sharpness(pil_image).enhance(1.15)
    return np.array(pil_image)


def detect_hand_landmarks(image_path, output_path=None):
    try:
        mp_hands, mp_drawing = _get_mediapipe_solutions()
    except ImportError:
        logger.info("MediaPipe не е наличен.")
        return {"found": False, "landmarks": None, "output_path": None}

    image_rgb = _load_image_rgb(image_path)
    image_rgb = _preprocess_for_mediapipe(image_rgb)

    logger.info("MediaPipe detection start for: %s", image_path)

    with mp_hands.Hands(
        static_image_mode=True,
        max_num_hands=1,
        model_complexity=1,
        min_detection_confidence=0.10,
    ) as hands:
        results = hands.process(image_rgb)

        if not results.multi_hand_landmarks:
            logger.info("MediaPipe не откри ръка за: %s", image_path)
            return {"found": False, "landmarks": None, "output_path": None}

        hand_landmarks = results.multi_hand_landmarks[0]

        if output_path:
            annotated_image = image_rgb.copy()
            mp_drawing.draw_landmarks(
                annotated_image,
                hand_landmarks,
                mp_hands.HAND_CONNECTIONS,
            )
            annotated_bgr = cv2.cvtColor(annotated_image, cv2.COLOR_RGB2BGR)
            output_path = Path(output_path)
            output_path.parent.mkdir(parents=True, exist_ok=True)
            cv2.imwrite(str(output_path), annotated_bgr)

        landmarks = []
        height, width, _ = image_rgb.shape
        for lm in hand_landmarks.landmark:
            landmarks.append((int(lm.x * width), int(lm.y * height)))

        logger.info("MediaPipe откри %d landmarks за: %s", len(landmarks), image_path)
        return {"found": True, "landmarks": landmarks, "output_path": str(output_path) if output_path else None}


def get_nail_regions(landmarks):
    if not landmarks or len(landmarks) < 21:
        return {}

    nail_regions = {}

    for finger_name, tip_idx in FINGER_TIPS.items():
        dip_idx = FINGER_DIPS[finger_name]
        base_idx = FINGER_BASES[finger_name]

        tip_x, tip_y = landmarks[tip_idx]
        dip_x, dip_y = landmarks[dip_idx]
        base_x, base_y = landmarks[base_idx]

        # Нокътна ос: DIP -> TIP
        ndx = tip_x - dip_x
        ndy = tip_y - dip_y
        nail_axis_len = math.hypot(ndx, ndy)

        # Ос на пръста: BASE -> DIP (ползваме само помощно)
        fdx = dip_x - base_x
        fdy = dip_y - base_y
        finger_axis_len = math.hypot(fdx, fdy)

        # Центърът на нокътя да е малко „преди“ върха, не извън него
        center_x = int(tip_x - ndx * 0.22)
        center_y = int(tip_y - ndy * 0.22)

        # Размерът да следва най-вече TIP↔DIP (реална нокътна зона)
        raw_width = nail_axis_len * 0.95
        raw_height = nail_axis_len * 0.78

        # Лек стабилизатор с BASE↔DIP, но ограничен
        raw_width = (raw_width * 0.85) + (finger_axis_len * 0.15)

        nail_width = max(14, int(raw_width))
        nail_height = max(12, int(raw_height))

        # Ъгъл по нокътната ос (по-стабилен за ориентация на дизайна)
        angle = math.degrees(math.atan2(ndy, ndx))

        nail_regions[finger_name] = {
            "center": (center_x, center_y),
            "width": nail_width,
            "height": nail_height,
            "angle": angle,
            "tip": (tip_x, tip_y),
            "dip": (dip_x, dip_y),
            "base": (base_x, base_y),
        }

    return nail_regions


def detect_hand_landmarks_and_nails(image_path, output_path=None):
    detection = detect_hand_landmarks(image_path, output_path=output_path)
    if not detection["found"]:
        logger.info("Landmarks не са открити за изображението: %s", image_path)
        return {"found": False, "landmarks": None, "nail_regions": {}, "output_path": detection["output_path"]}

    nail_regions = get_nail_regions(detection["landmarks"])
    logger.info("Landmarks открити за %s. Nail regions: %s", image_path, list(nail_regions.keys()))
    return {"found": True, "landmarks": detection["landmarks"], "nail_regions": nail_regions, "output_path": detection["output_path"]}


def _resize_image_to_width(image, target_width):
    target_width = max(1, int(target_width))
    ratio = target_width / image.width
    return image.resize((target_width, max(1, int(image.height * ratio))), Image.Resampling.LANCZOS)


def _resize_image_for_nail(image, target_width, max_height):
    """
    Оразмеряване, което първо следва ширината (по-удобно за tuning),
    а после ограничава височината, ако е прекалено голяма.
    """
    target_width = max(1, int(target_width))
    max_height = max(1, int(max_height))

    # 1) width-driven resize
    ratio = target_width / image.width
    new_w = target_width
    new_h = max(1, int(image.height * ratio))
    resized = image.resize((new_w, new_h), Image.Resampling.LANCZOS)

    # 2) height clamp (ако трябва)
    if resized.height > max_height:
        ratio2 = max_height / resized.height
        clamp_w = max(1, int(resized.width * ratio2))
        clamp_h = max_height
        resized = resized.resize((clamp_w, clamp_h), Image.Resampling.LANCZOS)

    return resized


def _paste_rotated_overlay(base_image, overlay_image, center_x, center_y, angle_deg):
    rotated = overlay_image.rotate(-angle_deg, resample=Image.Resampling.BICUBIC, expand=True)
    x = int(center_x - rotated.width / 2)
    y = int(center_y - rotated.height / 2)
    x = max(0, min(x, base_image.width - rotated.width))
    y = max(0, min(y, base_image.height - rotated.height))
    base_image.alpha_composite(rotated, dest=(x, y))


def apply_design_overlay(hand_image_path, design_image_path, output_path, alpha=0.85, debug_output_path=None):
    hand_image = Image.open(hand_image_path).convert("RGBA")
    design_image = Image.open(design_image_path).convert("RGBA")

    hand_width, hand_height = hand_image.size
    overlay_done = False

    if is_mediapipe_available():
        detection = detect_hand_landmarks_and_nails(hand_image_path, output_path=None)

        if detection["found"] and detection["nail_regions"]:
            logger.info("USING PER-FINGER BRANCH")

            for finger_name in ["thumb", "index", "middle", "ring", "pinky"]:
                region = detection["nail_regions"].get(finger_name)
                if not region:
                    continue

                rules = FINGER_OVERLAY_RULES.get(finger_name, {})

                center_x, center_y = region["center"]
                base_angle = region["angle"]

                center_x += rules.get("center_x_shift", 0)
                center_y += rules.get("center_y_shift", 0)
                center_y += GLOBAL_NAIL_Y_SHIFT

                raw_angle = base_angle + SPRITE_BASE_ANGLE_OFFSET + rules.get("angle_shift", 0)
                angle_min = rules.get("angle_min", -180)
                angle_max = rules.get("angle_max", 180)
                angle = max(angle_min, min(angle_max, raw_angle))

                # Увеличение почти 2х по ширина
                target_w = int(
                    region["width"]
                    * rules.get("width_multiplier", 1.0)
                    * GLOBAL_NAIL_WIDTH_SCALE
                )
                max_h = int(
                    region["height"]
                    * rules.get("height_multiplier", 1.0)
                    * GLOBAL_NAIL_HEIGHT_SCALE
                )
                # Част от процеса на наслагване за конкретен пръст
                finger_overlay = design_image.copy()
                finger_overlay = _resize_image_for_nail(
                    image=finger_overlay,
                    target_width=target_w,
                    max_height=max_h,
                )

                alpha_channel = finger_overlay.getchannel("A").point(lambda p: int(p * alpha))
                finger_overlay.putalpha(alpha_channel)

                # Наслагване с отчитане на ротацията (ъгъла на пръста)
                _paste_rotated_overlay(
                    base_image=hand_image,
                    overlay_image=finger_overlay,
                    center_x=center_x,
                    center_y=center_y,
                    angle_deg=angle,
                )

                overlay_done = True

    if not overlay_done:
        logger.info("USING FALLBACK BRANCH")
        target_width = int(hand_width * 0.22)
        fallback_overlay = _resize_image_to_width(design_image, target_width)
        alpha_channel = fallback_overlay.getchannel("A").point(lambda p: int(p * alpha))
        fallback_overlay.putalpha(alpha_channel)

        x = max(0, min(int(hand_width * 0.39), hand_width - fallback_overlay.width))
        y = max(0, min(int(hand_height * 0.42), hand_height - fallback_overlay.height))
        hand_image.alpha_composite(fallback_overlay, dest=(x, y))

    output_path = Path(output_path)
    output_path.parent.mkdir(parents=True, exist_ok=True)
    result = hand_image.convert("RGB")
    result.save(output_path, quality=95)

    logger.info("Processed image saved at: %s (exists=%s)", output_path, output_path.exists())

    return output_path