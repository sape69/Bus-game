extends Node

# ==========================================
# BUS MATCH OUT
# GAME COLORS
# ==========================================
# Pelin matkustaja- ja bussivärit
# ==========================================


const RED := Color("#ef5350")
const BLUE := Color("#42a5f5")
const GREEN := Color("#66bb6a")
const YELLOW := Color("#ffca28")


func get_colors() -> Array:
	return [
		RED,
		BLUE,
		GREEN,
		YELLOW
	]


func get_color(index: int) -> Color:
	var colors := get_colors()

	if index < 0:
		return colors[0]

	if index >= colors.size():
		return colors[0]

	return colors[index]


func get_color_name(index: int) -> String:
	match index:
		0:
			return "Punainen"
		1:
			return "Sininen"
		2:
			return "Vihreä"
		3:
			return "Keltainen"
		_:
			return "Tuntematon"


func get_color_count() -> int:
	return 4