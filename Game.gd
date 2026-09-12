extends Node2D

# ==========================================
# BUS MATCH OUT
# ==========================================
# Modularisoitu toimiva versio
# ==========================================


const COLS := 5
const ROWS := 5

const CELL_SIZE := 65.0
const GRID_X := 20.0
const GRID_Y := 125.0

const BUS_Y := 665.0
const BUS_WIDTH := 100.0
const BUS_HEIGHT := 70.0
const BUS_GAP := 15.0

const PASSENGER_RADIUS := 22.0
const MOVE_TIME := 0.35


# ==========================================
# COLOR MODULE
# ==========================================

var game_colors

var colors := [
	Color("#ef5350"),
	Color("#42a5f5"),
	Color("#66bb6a"),
	Color("#ffca28")
]

var dark_background := Color("#101820")
var grid_color := Color("#263238")
var grid_border := Color("#455a64")
var white := Color("#ffffff")
var dark := Color("#111111")


# ==========================================
# GAME INPUT MODULE
# ==========================================

var game_input


# ==========================================
# SCORE MODULE
# ==========================================

var score_manager


# ==========================================
# GAME DATA
# ==========================================

var passengers: Array = []
var buses: Array = []

var selected_passenger := -1

var score := 0
var lives := 3
var game_won := false
var game_over := false
var busy := false


# ==========================================
# UI
# ==========================================

var game_ui


# ==========================================
# READY
# ==========================================

func _ready():

	# --------------------------------------
	# COLOR MODULE
	# --------------------------------------

	game_colors = preload(
		"res://scripts/data/colors/game_colors.gd"
	).new()

	add_child(game_colors)

	colors = game_colors.get_colors()


	# --------------------------------------
	# INPUT MODULE
	# --------------------------------------

	game_input = preload(
		"res://scripts/game/input/game_input.gd"
	).new()

	add_child(game_input)


	# --------------------------------------
	# SCORE MODULE
	# --------------------------------------

	score_manager = preload(
		"res://scripts/game/score/score_manager.gd"
	).new()

	add_child(score_manager)


	# --------------------------------------
	# UI MODULE
	# --------------------------------------

	game_ui = preload(
		"res://scripts/ui/game_ui.gd"
	).new()

	add_child(game_ui)

	game_ui.setup(
		self,
		restart_game
	)


	# --------------------------------------
	# CREATE LEVEL
	# --------------------------------------

	create_level()

	update_info()

	queue_redraw()


# ==========================================
# LEVEL
# ==========================================

func create_level():

	passengers.clear()
	buses.clear()

	score = score_manager.reset_score()

	lives = 3

	selected_passenger = -1

	game_won = false
	game_over = false
	busy = false


	# --------------------------------------
	# MATKUSTAJAT
	# --------------------------------------

	var passenger_colors := [
		0, 0, 0, 0, 0,
		1, 1, 1, 1, 1,
		2, 2, 2, 2, 2,
		3, 3, 3, 3, 3,
		0, 1, 2, 3, 0
	]

	passenger_colors.shuffle()


	var index := 0


	for y in range(ROWS):

		for x in range(COLS):

			var grid_position := Vector2i(x, y)

			var passenger := {
				"grid": grid_position,
				"color": passenger_colors[index],
				"active": true,
				"moving": false,
				"position": get_passenger_position(
					grid_position
				)
			}

			passengers.append(passenger)

			index += 1


	# --------------------------------------
	# BUSSIT
	# --------------------------------------

	for i in range(4):

		var bus := {
			"color": i,
			"capacity": 4,
			"filled": 0,
			"active": true,
			"departing": false,
			"offset_x": 0.0,
			"passengers": []
		}

		buses.append(bus)


	update_info()
	queue_redraw()


# ==========================================
# PASSENGER POSITION
# ==========================================

func get_passenger_position(
	grid_pos: Vector2i
) -> Vector2:

	return Vector2(
		GRID_X +
		grid_pos.x * CELL_SIZE +
		CELL_SIZE / 2,

		GRID_Y +
		grid_pos.y * CELL_SIZE +
		CELL_SIZE / 2
	)


# ==========================================
# INPUT
# ==========================================

func _input(event):

	if game_won or game_over or busy:
		return

	if game_input == null:
		return


	var input_position := game_input.handle_input(
		event
	)


	if not game_input.has_input(
		input_position
	):
		return


	handle_click(
		input_position
	)


# ==========================================
# CLICK
# ==========================================

func handle_click(pos: Vector2):

	# --------------------------------------
	# MATKUSTAJAT
	# --------------------------------------

	for i in range(passengers.size()):

		var passenger = passengers[i]

		if not passenger.active:
			continue

		if passenger.moving:
			continue

		var center: Vector2 = passenger.position

		if pos.distance_to(center) <= PASSENGER_RADIUS + 8:

			select_passenger(i)

			return


	# --------------------------------------
	# BUSSIT
	# --------------------------------------

	for i in range(buses.size()):

		if not buses[i].active:
			continue

		var rect := get_bus_rect(i)

		if rect.has_point(pos):

			if selected_passenger >= 0:

				put_passenger_in_bus(
					selected_passenger,
					i
				)

			return


# ==========================================
# SELECT PASSENGER
# ==========================================

func select_passenger(index: int):

	if index < 0:
		return

	if index >= passengers.size():
		return

	if not passengers[index].active:
		return

	if passengers[index].moving:
		return

	selected_passenger = index

	update_info()
	queue_redraw()


# ==========================================
# PUT PASSENGER IN BUS
# ==========================================

func put_passenger_in_bus(
	passenger_index: int,
	bus_index: int
):

	if passenger_index < 0:
		return

	if bus_index < 0:
		return

	if passenger_index >= passengers.size():
		return

	if bus_index >= buses.size():
		return


	var passenger = passengers[
		passenger_index
	]

	var bus = buses[
		bus_index
	]


	# --------------------------------------
	# VÄÄRÄ BUSSI
	# --------------------------------------

	if passenger.color != bus.color:

		lives -= 1

		selected_passenger = -1

		update_info()
		queue_redraw()


		if lives <= 0:

			game_over = true

			busy = false

			update_info()
			queue_redraw()

		return


	# --------------------------------------
	# BUSSI TÄYNNÄ
	# --------------------------------------

	if bus.filled >= bus.capacity:

		update_info()

		return


	# --------------------------------------
	# OIKEA BUSSI
	# --------------------------------------

	selected_passenger = -1

	b