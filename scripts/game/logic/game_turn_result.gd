extends Node

# ==========================================
# BUS MATCH OUT
# GAME TURN RESULT
# ==========================================
# Pelivuoron lopputuloksen määrittely
# ==========================================


const RESULT_INVALID := "invalid"
const RESULT_CONTINUE := "continue"
const RESULT_WRONG_BUS := "wrong_bus"
const RESULT_BUS_FULL := "bus_full"
const RESULT_BOARDED := "boarded"
const RESULT_WON := "won"
const RESULT_GAME_OVER := "game_over"


func invalid() -> String:
	return RESULT_INVALID


func continue_game() -> String:
	return RESULT_CONTINUE


func wrong_bus() -> String:
	return RESULT_WRONG_BUS


func bus_full() -> String:
	return RESULT_BUS_FULL


func boarded() -> String:
	return RESULT_BOARDED


func won() -> String:
	return RESULT_WON


func game_over() -> String:
	return RESULT_GAME_OVER


func is_valid(result: String) -> bool:
	return result != RESULT_INVALID


func is_finished(result: String) -> bool:
	return (
		result == RESULT_WON
		or result == RESULT_GAME_OVER
	)


func is_success(result: String) -> bool:
	return (
		result == RESULT_BOARDED
		or result == RESULT_WON
	)


func is_error(result: String) -> bool:
	return (
		result == RESULT_WRONG_BUS
		or result == RESULT_BUS_FULL
		or result == RESULT_GAME_OVER
	)