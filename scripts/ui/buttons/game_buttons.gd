extends Node

# ==========================================
# BUS MATCH OUT
# GAME BUTTONS
# ==========================================
# Pelin painikkeiden hallinta
# ==========================================


var restart_button: Button


# ==========================================
# SETUP
# ==========================================

func setup(
        parent: Node,
        restart_callback: Callable
):

        create_restart_button(
                parent,
                restart_callback
        )


# ==========================================
# RESTART BUTTON
# ==========================================

func create_restart_button(
        parent: Node,
        restart_callback: Callable
):

        restart_button = Button.new()

        restart_button.text = "🔄 UUDELLEEN"

        restart_button.position = Vector2(
                145,
                770
        )

        restart_button.size = Vector2(
                190,
                55
        )

        restart_button.add_theme_font_size_override(
                "font_size",
                18
        )

        restart_button.pressed.connect(
                restart_callback
        )

        parent.add_child(
                restart_button
        )


# ==========================================
# SET BUTTON TEXT
# ==========================================

func set_restart_text(
        text: String
):

        if restart_button == null:
                return

        restart_button.text = text


# ==========================================
# ENABLE BUTTON
# ==========================================

func set_restart_enabled(
        enabled: bool
):

        if restart_button == null:
                return

        restart_button.disabled = not enabled