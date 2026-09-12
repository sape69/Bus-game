extends Node

# ==========================================
# BUS MATCH OUT
# GAME UI
# ==========================================
# Pelin käyttöliittymän hallinta
# ==========================================


var title_label: Label
var info_label: Label
var score_label: Label
var lives_label: Label
var restart_button: Button


# ==========================================
# SETUP
# ==========================================

func setup(
        parent: Node,
        restart_callback: Callable
):

        create_title(parent)

        create_score_label(parent)

        create_lives_label(parent)

        create_info_label(parent)

        create_restart_button(
                parent,
                restart_callback
        )


# ==========================================
# TITLE
# ==========================================

func create_title(
        parent: Node
):

        title_label = Label.new()

        title_label.text = "🚌 BUS MATCH"

        title_label.position = Vector2(
                20,
                15
        )

        title_label.add_theme_font_size_override(
                "font_size",
                30
        )

        parent.add_child(
                title_label
        )


# ==========================================
# SCORE
# ==========================================

func create_score_label(
        parent: Node
):

        score_label = Label.new()

        score_label.position = Vector2(
                20,
                65
        )

        score_label.add_theme_font_size_override(
                "font_size",
                18
        )

        parent.add_child(
                score_label
        )


# ==========================================
# LIVES
# ==========================================

func create_lives_label(
        parent: Node
):

        lives_label = Label.new()

        lives_label.position = Vector2(
                330,
                65
        )

        lives_label.add_theme_font_size_override(
                "font_size",
                18
        )

        parent.add_child(
                lives_label
        )


# ==========================================
# INFO
# ==========================================

func create_info_label(
        parent: Node
):

        info_label = Label.new()

        info_label.position = Vector2(
                20,
                95
        )

        info_label.add_theme_font_size_override(
                "font_size",
                16
        )

        parent.add_child(
                info_label
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
# UPDATE SCORE
# ==========================================

func update_score(
        score: int
):

        if score_label == null:
                return

        score_label.text = (
                "⭐ Pisteet: %d" % score
        )


# ==========================================
# UPDATE LIVES
# ==========================================

func update_lives(
        lives: int
):

        if lives_label == null:
                return

        lives_label.text = (
                "❤️ Elämät: %d" % lives
        )


# ==========================================
# UPDATE INFO
# ==========================================

func update_info(
        message: String
):

        if info_label == null:
                return

        info_label.text = message


# ==========================================
# UPDATE ALL
# ==========================================

func update_all(
        score: int,
        lives: int,
        message: String
):

        update_score(
                score
        )

        update_lives(
                lives
        )

        update_info(
                message
        )