extends Node

# ==========================================
# BUS MATCH OUT
# GAME LOADER
# ==========================================
# Pelin tasodatan lataaminen
# ==========================================


func load_level_data(level_data) -> Dictionary:
	if level_data == null:
		return {}

	var data := {
		"passenger_colors": level_data.get_default_passenger_colors(),
		"bus_count": level_data.get_bus_count(),
		"bus_capacity": level_data.get_bus_capacity(),
		"columns": level_data.get_columns(),
		"rows": level_data.get_rows()
	}

	return data


func get_passenger_colors(level_data) -> Array:
	if level_data == null:
		return []

	return level_data.get_default_passenger_colors()


func get_bus_count(level_data) -> int:
	if level_data == null:
		return 0

	return level_data.get_bus_count()


func get_bus_capacity(level_data) -> int:
	if level_data == null:
		return 0

	return level_data.get_bus_capacity()


func get_columns(level_data) -> int:
	if level_data == null:
		return 0

	return level_data.get_columns()


func get_rows(level_data) -> int:
	if level_data == null:
		return 0

	return level_data.get_rows()