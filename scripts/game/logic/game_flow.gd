extends Node

# ==========================================
# BUS MATCH OUT
# GAME FLOW
# ==========================================
# Pelin etenemisen hallinta
# ==========================================


func reset(
	game_state
) -> void:

	if game_state == null:
		return

	game_state.reset()


func start_turn(
	game_state
) -> bool:

	if game_state == null:
		return false

	if game_state.is_won():
		return false

	if game_state.is_game_over():
		return false

	if game_state.is_busy():
		return false

	return true


func begin_action(
	game_state
) -> bool:

	if game_state == null:
		return false

	if game_state.is_won():
		return false

	if game_state.is_game_over():
		return false

	if game_state.is_busy():
		return false

	game_state.set_busy(true)

	return true


func end_action(
	game_state
) -> void:

	if game_state == null:
		return

	game_state.set_busy(false)


func finish_win(
	game_state
) -> void:

	if game_state == null:
		return

	game_state.set_won()


func finish_game_over(
	game_state
) -> void:

	if game_state == null:
		return

	game_state.set_game_over()


func can_continue(
	game_state
) -> bool:

	if game_state == null:
		return false

	if game_state.is_won():
		return false

	if game_state.is_game_over():
		return false

	return true