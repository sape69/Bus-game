extends Node

# ==========================================
# BUS MATCH OUT
# GAME CREATOR
# ==========================================
# Matkustajien ja bussien luominen
# ==========================================


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


func create_level(
	passenger_generator,
	bus_generator,
	cols: int,
	rows: int,
	passenger_colors: Array,
	bus_count: int,
	bus_capacity: int,
	cell_position_callback: Callable
) -> Dictionary:

	return {
		"passengers": create_passengers(
			passenger_generator,
			cols,
			rows,
			passenger_colors,
			cell_position_callback
		),
		"buses": create_buses(
			bus_generator,
			bus_count,
			bus_capacity
		)
	}