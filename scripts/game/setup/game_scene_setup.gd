extends Node

# ==========================================
# BUS MATCH OUT
# GAME SCENE SETUP
# ==========================================
# Pelinäkymän alustuksen hallinta
# ==========================================


func setup_scene(
	parent: Node,
	ui,
	restart_callback: Callable
) -> void:

	if parent == null:
		return

	if ui == null:
		return

	ui.setup(
		parent,
		restart_callback
	)


func update_ui(
	ui,
	score: int,
	lives: int,
	message: String
) -> void:

	if ui == null:
		return

	ui.update_all(
		score,
		lives,
		message
	)


func update_score(
	ui,
	score: int
) -> void:

	if ui == null:
		return

	ui.update_score(score)


func update_lives(
	ui,
	lives: int
) -> void:

	if ui == null:
		return

	ui.update_lives(lives)


func update_message(
	ui,
	message: String
) -> void:

	if ui == null:
		return

	ui.update_info(message)