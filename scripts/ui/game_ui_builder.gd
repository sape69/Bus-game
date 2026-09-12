extends Node

# ==========================================
# BUS MATCH OUT
# GAME UI BUILDER
# ==========================================
# Käyttöliittymän luominen
# ==========================================


func create_ui(
	parent: Node,
	restart_callback: Callable
) -> Dictionary:

	var result := {
		"title_label": null,
		"score_label": null,
		"lives_label": null,
		"info_label": null,
		"restart_button": null
	}

	if parent == null:
		return result


	# ======================================
	# TITLE
	# ======================================

	var title_label := Label.new()

	title_label.text = "🚌 BUS MATCH"

	title_label.position = Vector2(
		20,
		15
	)

	title_label.add_theme_font_size_override(
		"font_size",
		30
	)

	parent.add_child(title_label)

	result["title_label"] = title_label


	# ======================================
	# SCORE
	# ======================================

	var score_label := Label.new()

	score_label.position = Vector2(
		20,
		65
	)

	score_label.add_theme_font_size_override(
		"font_size",
		18
	)

	parent.add_child(score_label)

	result["score_label"] = score_label


	# ======================================
	# LIVES
	# ======================================

	var lives_label := Label.new()

	lives_label.position = Vector2(
		330,
		65
	)

	lives_label.add_theme_font_size_override(
		"font_size",
		18
	)

	parent.add_child(lives_label)

	result["lives_label"] = lives_label


	# ======================================
	# INFO
	# ======================================

	var info_label := Label.new()

	info_label.position = Vector2(
		20,
		95
	)

	info_label.add_theme_font_size_override(
		"font_size",
		16
	)

	parent.add_child(info_label)

	result["info_label"] = info_label


	# ======================================
	# RESTART BUTTON
	# ======================================

	var restart_button := Button.new()

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

	parent.add_child(restart_button)

	result["restart_button"] = restart_button


	return result