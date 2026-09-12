extends Node

# ==========================================
# BUS MATCH OUT
# GAME CONTROLLER
# ==========================================
# Pelin toiminnan ohjaus
# ==========================================


func can_process_input(
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


func handle_passenger_selection(
	passengers: Array,
	index: int
) -> int:

	if index < 0:
		return -1

	if index >= passengers.size():
		return -1

	var passenger = passengers[index]

	if not passenger.active:
		return -1

	if passenger.moving:
		return -1

	return index


func handle_bus_selection(
	buses: Array,
	index: int
) -> bool:

	if index < 0:
		return false

	if index >= buses.size():
		return false

	var bus = buses[index]

	if not bus.active:
		return false

	if bus.departing:
		return false

	return true


func can_board_passenger(
	passenger,
	bus
) -> bool:

	if passenger == null:
		return false

	if bus == null:
		return false

	if not passenger.active:
		return false

	if passenger.moving:
		return false

	if not bus.active:
		return false

	if bus.departing:
		return false

	if bus.filled >= bus.capacity:
		return false

	if passenger.color != bus.color:
		return false

	return true


func get_boarding_result(
	passenger,
	bus
) -> String:

	if passenger == null:
		return "invalid"

	if bus == null:
		return "invalid"

	if not passenger.active:
		return "invalid"

	if passenger.moving:
		return "invalid"

	if not bus.active:
		return "invalid"

	if bus.departing:
		return "invalid"

	if passenger.color != bus.color:
		return "wrong_bus"

	if bus.filled >= bus.capacity:
		return "bus_full"

	return "correct"


func should_depart_bus(bus) -> bool:

	if bus == null:
		return false

	if not bus.active:
		return false

	if bus.departing:
		return false

	return bus.filled >= bus.capacity


func should_end_game(
	passengers: Array,
	lives: int
) -> String:

	if lives <= 0:
		return "game_over"

	for passenger in passengers:
		if passenger.active:
			return "playing"

	return "won"


func reset_selection() -> int:
	return -1