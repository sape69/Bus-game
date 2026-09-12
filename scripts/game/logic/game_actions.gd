extends Node

# ==========================================
# BUS MATCH OUT
# GAME ACTIONS
# ==========================================
# Pelaajan toimintojen hallinta
# ==========================================


func select_passenger(
	passengers: Array,
	index: int
) -> int:

	if index < 0:
		return -1

	if index >= passengers.size():
		return -1

	if not passengers[index].active:
		return -1

	if passengers[index].moving:
		return -1

	return index


func clear_selection() -> int:
	return -1


func start_boarding(
	passengers: Array,
	passenger_index: int,
	buses: Array,
	bus_index: int
) -> Dictionary:

	var result := {
		"success": false,
		"wrong_bus": false,
		"bus_full": false,
		"passenger_color": -1
	}

	if passenger_index < 0:
		return result

	if passenger_index >= passengers.size():
		return result

	if bus_index < 0:
		return result

	if bus_index >= buses.size():
		return result

	var passenger = passengers[passenger_index]
	var bus = buses[bus_index]

	result["passenger_color"] = passenger.color

	if not passenger.active:
		return result

	if passenger.moving:
		return result

	if not bus.active:
		return result

	if bus.departing:
		return result

	if passenger.color != bus.color:
		result["wrong_bus"] = true
		return result

	if bus.filled >= bus.capacity:
		result["bus_full"] = true
		return result

	result["success"] = true

	return result


func apply_boarding(
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

	if passenger.color != bus.color:
		return false

	if bus.filled >= bus.capacity:
		return false

	passenger.moving = true

	bus.filled += 1
	bus.passengers.append(
		passenger.color
	)

	return true


func finish_boarding(passenger) -> void:

	if passenger == null:
		return

	passenger.active = false
	passenger.moving = false


func remove_life(current_lives: int) -> int:

	var lives := current_lives - 1

	if lives < 0:
		lives = 0

	return lives


func add_score(
	current_score: int,
	amount: int = 10
) -> int:

	return current_score + amount