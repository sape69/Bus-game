extends Node

# ==========================================
# BUS MATCH OUT
# MOVEMENT
# ==========================================
# Pelin liike- ja tween-aputoiminnot
# ==========================================


# ==========================================
# DEFAULT MOVE TIME
# ==========================================

const DEFAULT_MOVE_TIME := 0.35


# ==========================================
# MOVE VECTOR2
# ==========================================

func move_vector2(
        start_position: Vector2,
        target_position: Vector2,
        duration: float = DEFAULT_MOVE_TIME
) -> Tween:

        var tween := create_tween()

        tween.set_trans(
                Tween.TRANS_QUAD
        )

        tween.set_ease(
                Tween.EASE_IN_OUT
        )

        tween.tween_method(
                func(value: Vector2):
                        pass,
                start_position,
                target_position,
                duration
        )

        return tween


# ==========================================
# CREATE VECTOR2 TWEEN
# ==========================================

func create_vector2_tween(
        start_position: Vector2,
        target_position: Vector2,
        duration: float = DEFAULT_MOVE_TIME,
        transition: Tween.TransitionType = Tween.TRANS_QUAD,
        ease: Tween.EaseType = Tween.EASE_IN_OUT
) -> Tween:

        var tween := create_tween()

        tween.set_trans(
                transition
        )

        tween.set_ease(
                ease
        )

        return tween


# ==========================================
# CREATE FLOAT TWEEN
# ==========================================

func create_float_tween(
        start_value: float,
        target_value: float,
        duration: float,
        transition: Tween.TransitionType = Tween.TRANS_QUAD,
        ease: Tween.EaseType = Tween.EASE_IN_OUT
) -> Tween:

        var tween := create_tween()

        tween.set_trans(
                transition
        )

        tween.set_ease(
                ease
        )

        tween.tween_method(
                func(value: float):
                        pass,
                start_value,
                target_value,
                duration
        )

        return tween


# ==========================================
# MOVE TIME
# ==========================================

func get_default_move_time() -> float:

        return DEFAULT_MOVE_TIME