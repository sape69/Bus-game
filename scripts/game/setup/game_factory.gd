extends Node

# ==========================================
# BUS MATCH OUT
# GAME FACTORY
# ==========================================
# Pelin objektien luomisen keskitetty hallinta
# ==========================================


func create_passenger(
	passenger_grid: Vector2i,
	passenger_color: int,
	passenger_position: Vector2
) -> Dictionary:

	return {
		"grid": passenger_grid,
		"color": passenger_color,
		"active": true,
		"moving": false,
		"position": passenger_position
	}


func create_bus(
	bus_color: int,
	bus_capacity: int
) -> Dictionary:

	return {
		"color": bus_color,
		"capacity": bus_capacity,
		"filled": 0,
		"active": true,
		"departing": false,
		"offset_x": 0.0,
		"passengers": []
	}


func create_passenger_list(
	cols: int,
	rows: int,
	passenger_colors: Array,
	cell_position_callback: Callable
) -> Array:

	var result: Array = []
	var index := 0

	for y in range(rows):
		for x in range(cols):

			if index >= passenger_colors.size():
				break

			var grid_position := Vector2i(x, y)

			result.append(
				create_passenger(
					grid_position,
					passenger_colors[index],
					cell_position_callback.call(grid_position)
				)
			)

			index += 1

	return result


func create_bus_list(
	bus_count: int,
	bus_capacity: int
) -> Array:

	var result: Array = []

	for i in range(bus_count):
		result.append(
			create_bus(
				i,
				bus_capacity
			)
		)

	return result