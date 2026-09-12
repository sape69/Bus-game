extends Node

# ==========================================
# BUS MATCH OUT
# GAME INITIALIZER
# ==========================================
# Pelin alustuksen keskitetty hallinta
# ==========================================


func initialize_game(
	game_state,
	bus_generator,
	passenger_generator,
	bus_count: int,
	bus_capacity: int,
	cols: int,
	rows: int,
	passenger_colors: Array,
	cell_position_callback: Callable
) -> Dictionary:

	var result := {
		"passengers": [],
		"buses": []
	}

	if game_state != null:
		game_state.reset()

	if passenger_generator != null:
		result["passengers"] = passenger_generator.create_passengers(
			cols,
			rows,
			passenger_colors,
			cell_position_callback
		)

	if bus_generator != null:
		result["buses"] = bus_generator.create_buses(
			bus_count,
			bus_capacity
		)

	return result


func reset_game(
	game_state,
	bus_generator,
	buses: Array
) -> Array:

	if game_state != null:
		game_state.reset()

	if bus_generator != null:
		return bus_generator.reset_buses(buses)

	return buses