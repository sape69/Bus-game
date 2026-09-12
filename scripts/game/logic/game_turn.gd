extends Node

# ==========================================
# BUS MATCH OUT
# GAME TURN
# ==========================================
# Yhden pelivuoron hallinta
# ==========================================


func can_start(
	game_won: bool,
	game_over: bool,
	busy: bool
) -> bool:

	if game_won:
		return false

	if game_over:
		return false

	if busy:
		return false

	return true


func begin(
	game_state
) -> bool:

	if game_state == null:
		return false

	if not can_start(
		game_state.is_won(),
		game_state.is_game_over(),
		game_state.is_busy()
	):
		return false

	game_state.set_busy(true)

	return true


func finish(
	game_state
) -> void:

	if game_state == null:
		return

	game_state.set_busy(false)


func cancel(
	game_state
) -> void:

	if game_state == null:
		return

	game_state.clear_selection()
	game_state.set_busy(false)


func select_passenger(
	game_state,
	passengers: Array,
	index: int
) -> bool:

	if game_state == null:
		return false

	if not can_start(
		game_state.is_won(),
		game_state.is_game_over(),
		game_state.is_busy()
	):
		return false

	if index < 0:
		return false

	if index >= passengers.size():
		return false

	var passenger = passengers[index]

	if not passenger.active:
		return false

	if passenger.moving:
		return false

	game_state.select_passenger(index)

	return true


func clear_selection(
	game_state
) -> void:

	if game_state == null:
		return

	game_state.clear_selection()


func get_selected_index(
	game_state
) -> int:

	if game_state == null:
		return -1

	return game_state.get_selected_passenger()