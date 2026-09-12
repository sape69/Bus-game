extends Node

# ==========================================
# BUS MATCH OUT
# GAME RULES
# ==========================================
# Pelin sääntöjen hallinta
# ==========================================


const DEFAULT_LIVES := 3
const BUS_CAPACITY := 4
const BOARDING_SCORE := 10


func get_default_lives() -> int:
	return DEFAULT_LIVES


func get_bus_capacity() -> int:
	return BUS_CAPACITY


func get_boarding_score() -> int:
	return BOARDING_SCORE


func is_correct_bus(
	passenger_color: int,
	bus_color: int
) -> bool:

	return passenger_color == bus_color


func is_wrong_bus(
	passenger_color: int,
	bus_color: int
) -> bool:

	return passenger_color != bus_color


func can_board(
	passenger_color: int,
	bus_color: int,
	filled: int,
	capacity: int,
	bus_active: bool,
	bus_departing: bool
) -> bool:

	if not bus_active:
		return false

	if bus_departing:
		return false

	if filled >= capacity:
		return false

	if passenger_color != bus_color:
		return false

	return true


func should_depart(
	filled: int,
	capacity: int,
	bus_active: bool,
	bus_departing: bool
) -> bool:

	if not bus_active:
		return false

	if bus_departing:
		return false

	return filled >= capacity


func has_game_over(lives: int) -> bool:
	return lives <= 0


func has_won(passengers: Array) -> bool:
	for passenger in passengers:
		if passenger.active:
			return false

	return true