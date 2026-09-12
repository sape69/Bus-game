extends Node

# ==========================================
# BUS MATCH OUT
# GAME STARTUP
# ==========================================
# Pelin käynnistyksen hallinta
# ==========================================


func start_game(game_state) -> void:
	if game_state == null:
		return

	game_state.reset()


func start_level(
	level_manager,
	level: int = 1
) -> void:

	if level_manager == null:
		return

	level_manager.set_level(level)


func prepare_level(
	level_data,
	level_manager,
	level: int = 1
) -> Dictionary:

	var result := {
		"level": level,
		"passenger_colors": [],
		"bus_count": 0,
		"bus_capacity": 0,
		"columns": 0,
		"rows": 0
	}

	if level_manager != null:
		level_manager.set_level(level)

	if level_data == null:
		return result

	result["passenger_colors"] = (
		level_data.get_default_passenger_colors()
	)

	result["bus_count"] = (
		level_data.get_bus_count()
	)

	result["bus_capacity"] = (
		level_data.get_bus_capacity()
	)

	result["columns"] = (
		level_data.get_columns()
	)

	result["rows"] = (
		level_data.get_rows()
	)

	return result