extends Node

# ==========================================
# BUS MATCH OUT
# GAME RESET
# ==========================================
# Pelin uudelleenkäynnistyksen hallinta
# ==========================================


func reset_state(game_state) -> void:
	if game_state == null:
		return

	game_state.reset()


func reset_buses(bus_generator, buses: Array) -> Array:
	if bus_generator == null:
		return buses

	return bus_generator.reset_buses(buses)


func reset_all(
	game_state,
	bus_generator,
	buses: Array
) -> Array:

	reset_state(game_state)

	return reset_buses(
		bus_generator,
		buses
	)