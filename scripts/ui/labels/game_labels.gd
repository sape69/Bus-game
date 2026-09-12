extends Node

# ==========================================
# BUS MATCH OUT
# GAME LABELS
# ==========================================
# Pelin tekstien ja Label-komponenttien hallinta
# ==========================================


var score_label: Label
var lives_label: Label
var info_label: Label


# ==========================================
# SETUP
# ==========================================

func setup(
        parent: Node
):

        create_score_label(parent)

        create_lives_label(parent)

        create_info_label(parent)


# ==========================================
# SCORE LABEL
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
# LIVES LABEL
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
# INFO LABEL
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