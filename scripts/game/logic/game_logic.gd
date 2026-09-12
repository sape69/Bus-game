extends Node

# ==========================================
# BUS MATCH OUT
# GAME LOGIC
# ==========================================
# Pelin päälogiikan pienet apufunktiot
# ==========================================


func get_remaining_passengers(passengers: Array) -> int:
	var remaining := 0

	for passenger in passengers:
		if passenger.active:
			remaining += 1

	return remaining


func can_select_passenger(
	passengers: Array,
	index: int
) -> bool:

	if index < 0:
		return false

	if index >= passengers.size():
		return false

	if not passengers[index].active:
		return false

	if passengers[index].moving:
		return false

	return true


func can_use_bus(
	buses: Array,
	index: int
) -> bool:

	if index < 0:
		return false

	if index >= buses.size():
		return false

	if not buses[index].active:
		return false

	if buses[index].departing:
		return false

	return true


func passenger_matches_bus(
	passenger,
	bus
) -> bool:

	if passenger == null:
		return false

	if bus == null:
		return false

	return passenger.color == bus.color


func bus_is_full(bus) -> bool:
	if bus == null:
		return false

	return bus.filled >= bus.capacity


func all_passengers_finished(
	passengers: Array
) -> bool:

	for passenger in passengers:
		if passenger.active:
			return false

	return true