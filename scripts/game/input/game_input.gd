extends Node

# ==========================================
# BUS MATCH OUT
# GAME INPUT
# ==========================================
# Hiiren ja kosketuksen syötteen tunnistus
# ==========================================


# ==========================================
# HANDLE INPUT
# ==========================================

func handle_input(
        event: InputEvent
) -> Vector2:

        if event is InputEventMouseButton:

                if event.button_index == MOUSE_BUTTON_LEFT:

                        if event.pressed:

                                return event.position


        if event is InputEventScreenTouch:

                if event.pressed:

                        return event.position


        return Vector2(
                -1,
                -1
        )


# ==========================================
# HAS INPUT
# ==========================================

func has_input(
        position: Vector2
) -> bool:

        return position.x >= 0 and position.y >= 0