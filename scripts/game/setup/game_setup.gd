extends Node

# ==========================================
# BUS MATCH OUT
# GAME SETUP
# ==========================================
# Pelin alustamisen apumoduuli
# ==========================================

func reset_game_state(game_state) -> void:
	if game_state == null:
		return

	game_state.reset()


func create_passengers(
	passenger_generator,
	cols: int,
	rows: int,
	passenger_colors: Array,
	cell_position_callback: Callable
) -> Array:
	if passenger_generator == null:
		return []

	return passenger_generator.create_passengers(
		cols,
		rows,
		passenger_colors,
		cell_position_callback
	)


func create_buses(
	bus_generator,
	bus_count: int,
	bus_capacity: int
) -> Array:
	if bus_generator == null:
		return []

	return bus_generator.create_buses(
		bus_count,
		bus_capacity
	)


func reset_buses(
	bus_generator,
	buses: Array
) -> Array:
	if bus_generator == null:
		return buses

	return bus_generator.reset_buses(buses)


func reset_game(
	game_state,
	bus_generator,
	buses: Array
) -> Array:
	reset_game_state(game_state)

	return reset_buses(
		bus_generator,
		buses
	)