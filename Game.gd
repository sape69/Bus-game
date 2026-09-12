extends Node2D

# ==========================================
# BUS MATCH OUT
# ==========================================
# Modularisoitu versio
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
	# LOAD COLOR MODULE
	# --------------------------------------

	game_colors = preload(
		"res://scripts/data/colors/game_colors.gd"
	).new()

	colors = game_colors.get_colors()


	# --------------------------------------
	# LOAD UI MODULE
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

	score = 0
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


	if event is InputEventMouseButton:

		if event.button_index == MOUSE_BUTTON_LEFT:

			if event.pressed:

				handle_click(
					event.position
				)


	if event is InputEventScreenTouch:

		if event.pressed:

			handle_click(
				event.position
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

	busy = true

	passenger.moving = true

	bus.filled += 1

	bus.passengers.append(
		passenger.color
	)

	score += 10


	var target := get_bus_passenger_position(
		bus_index,
		bus.filled - 1
	)

	var start: Vector2 = passenger.position


	var tween := create_tween()

	tween.set_trans(
		Tween.TRANS_QUAD
	)

	tween.set_ease(
		Tween.EASE_IN_OUT
	)


	tween.tween_method(
		func(value: Vector2):
			passenger.position = value
			queue_redraw(),
		start,
		target,
		MOVE_TIME
	)


	tween.tween_callback(
		func():

			passenger.active = false
			passenger.moving = false
			busy = false

			check_bus_full(
				bus_index
			)

			check_win()

			update_info()
			queue_redraw()
	)


# ==========================================
# BUS FULL
# ==========================================

func check_bus_full(
	bus_index: int
):

	if bus_index < 0:
		return

	if bus_index >= buses.size():
		return


	var bus = buses[
		bus_index
	]


	if bus.filled < bus.capacity:
		return

	if bus.departing:
		return


	bus.departing = true

	update_info()


	var tween := create_tween()

	tween.set_trans(
		Tween.TRANS_QUAD
	)

	tween.set_ease(
		Tween.EASE_IN
	)


	tween.tween_method(
		func(value: float):

			bus["offset_x"] = value

			queue_redraw(),

		0.0,
		520.0,
		0.7
	)


	tween.tween_callback(
		func():

			bus.active = false
			bus.departing = false
			bus["offset_x"] = 0.0

			queue_redraw()
	)


# ==========================================
# BUS POSITION
# ==========================================

func get_bus_x(
	index: int
) -> float:

	return 15.0 + index * (
		BUS_WIDTH + BUS_GAP
	)


func get_bus_rect(
	index: int
) -> Rect2:

	var x := get_bus_x(index)

	if index >= 0 and index < buses.size():

		x += float(
			buses[index].get(
				"offset_x",
				0.0
			)
		)

	return Rect2(
		x,
		BUS_Y,
		BUS_WIDTH,
		BUS_HEIGHT
	)


# ==========================================
# BUS PASSENGER POSITION
# ==========================================

func get_bus_passenger_position(
	bus_index: int,
	passenger_index: int
) -> Vector2:

	var rect := get_bus_rect(
		bus_index
	)

	var spacing := 22.0

	return Vector2(
		rect.position.x +
		20 +
		passenger_index * spacing,

		rect.position.y +
		30
	)


# ==========================================
# WIN
# ==========================================

func check_win():

	for passenger in passengers:

		if passenger.active:

			return


	game_won = true
	busy = false

	update_info()
	queue_redraw()


# ==========================================
# RESTART
# ==========================================

func restart_game():

	create_level()

	update_info()

	queue_redraw()


# ==========================================
# INFO
# ==========================================

func update_info():

	if game_ui == null:
		return


	game_ui.update_score(
		score
	)

	game_ui.update_lives(
		lives
	)


	if game_won:

		game_ui.update_info(
			"🎉 VOITIT! Pisteet: %d"
			% score
		)

		return


	if game_over:

		game_ui.update_info(
			"💥 PELI OHI!"
		)

		return


	var remaining := 0


	for passenger in passengers:

		if passenger.active:

			remaining += 1


	if selected_passenger >= 0:

		if selected_passenger < passengers.size():

			var color_index: int = passengers[
				selected_passenger
			].color

			game_ui.update_info(
				"Valittu: %s | Jäljellä: %d"
				% [
					get_color_name(
						color_index
					),
					remaining
				]
			)

	else:

		game_ui.update_info(
			"Valitse matkustaja | Jäljellä: %d"
			% remaining
		)


# ==========================================
# COLOR NAME
# ==========================================

func get_color_name(
	index: int
) -> String:

	if game_colors != null:

		return game_colors.get_color_name(
			index
		)

	match index:

		0:
			return "PUNAINEN"

		1:
			return "SININEN"

		2:
			return "VIHREÄ"

		3:
			return "KELTAINEN"

		_:
			return ""


# ==========================================
# DRAW
# ==========================================

func _draw():

	# --------------------------------------
	# TAUSTA
	# --------------------------------------

	draw_rect(
		Rect2(
			0,
			0,
			480,
			850
		),
		dark_background,
		true
	)


	# --------------------------------------
	# OTSIKON ALUE
	# --------------------------------------

	draw_rect(
		Rect2(
			0,
			0,
			480,
			110
		),
		Color("#162329"),
		true
	)


	# --------------------------------------
	# GRID
	# --------------------------------------

	for y in range(ROWS):

		for x in range(COLS):

			var rect := Rect2(
				GRID_X +
				x * CELL_SIZE,

			