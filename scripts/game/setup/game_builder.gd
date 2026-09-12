extends Node

# ==========================================
# BUS MATCH OUT
# GAME BUILDER
# ==========================================
# Pelitason rakentaminen valmiista moduuleista
# ==========================================


func build_level(
	level_data,
	passenger_generator,
	bus_generator,
	passenger_position,
	cols: int,
	rows: int
) -> Dictionary:

	var result := {
		"passengers": [],
		"buses": []
	}

	if level_data == null:
		return result

	var passenger_colors: Array = (
		level_data.get_default_passenger_colors()
	)

	var bus_count: int = (
		level_data.get_bus_count()
	)

	var bus_capacity: int = (
		level_data.get_bus_capacity()
	)

	if passenger_generator != null:
		result["passengers"] = (
			passenger_generator.create_passengers(
				cols,
				rows,
				passenger_colors,
				passenger_position.get_position
			)
		)

	if bus_generator != null:
		result["buses"] = (
			bus_generator.create_buses(
				bus_count,
				bus_capacity
			)
		)

	return result


func rebuild_level(
	level_data,
	passenger_generator,
	bus_generator,
	passenger_position,
	cols: int,
	rows: int
) -> Dictionary:

	return build_level(
		level_data,
		passenger_generator,
		bus_generator,
		passenger_position,
		cols,
		rows
	)