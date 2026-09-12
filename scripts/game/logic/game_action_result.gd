extends Node

# ==========================================
# BUS MATCH OUT
# GAME ACTION RESULT
# ==========================================
# Pelaajan toiminnon lopputulokset
# ==========================================

const SUCCESS := "success"
const INVALID := "invalid"
const WRONG_BUS := "wrong_bus"
const BUS_FULL := "bus_full"
const GAME_OVER := "game_over"
const WON := "won"


func success() -> String:
	return SUCCESS


func invalid() -> String:
	return INVALID


func wrong_bus() -> String:
	return WRONG_BUS


func bus_full() -> String:
	return BUS_FULL


func game_over() -> String:
	return GAME_OVER


func won() -> String:
	return WON


func is_success(result: String) -> bool:
	return result == SUCCESS


func is_invalid(result: String) -> bool:
	return result == INVALID


func is_wrong_bus(result: String) -> bool:
	return result == WRONG_BUS


func is_bus_full(result: String) -> bool:
	return result == BUS_FULL


func is_game_over(result: String) -> bool:
	return result == GAME_OVER


func is_won(result: String) -> bool:
	return result == WON


func is_finished(result: String) -> bool:
	return (
		result == GAME_OVER
		or result == WON
	)