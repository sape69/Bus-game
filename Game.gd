extends Node2D

# ==========================================
# BUS MATCH OUT
# ==========================================

const COLORS_SCRIPT = preload("res://scripts/data/colors/game_colors.gd")
const INPUT_SCRIPT = preload("res://scripts/game/input/game_input.gd")
const UI_SCRIPT = preload("res://scripts/ui/game_ui.gd")

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

var passengers: Array = []
var buses: Array = []

var selected_passenger := -1

var score := 0
var lives := 3

var game_won := false
var game_over := false
var busy := false

var colors
var game_input
var game_ui


func _ready():
	colors = COLORS_SCRIPT.new()
	add_child(colors)

	game_input = INPUT_SCRIPT.new()
	add_child(game_input)

	game_ui = UI_SCRIPT.new()
	add_child(game_ui)

	game_ui.setup(
		self,
		restart_game
	)

	create_level()
	queue_redraw()


# ==========================================
# LEVEL
# ==========================================

func create_level():
	passengers.clear()
	buses.clear()

	selected_passenger = -1

	score = 0
	lives = 3

	game_won = false
	game_over = false
	busy = false

	game_ui.update_all(
		score,
		lives,
		"Valitse matkustaja ja sitten oikea bussi."
	)

	create_passengers()
	create_buses()

	queue_redraw()


func create_passengers():
	var passenger_colors: Array = [
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

			var passenger := {
				"grid": Vector2i(x, y),
				"color": passenger_colors[index],
				"active": true,
				"moving": false,
				"position": get_passenger_position(Vector2i(x, y))
			}

			passengers.append(passenger)

			index += 1


func create_buses():
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


# ==========================================
# POSITIONS
# ==========================================

func get_passenger_position(grid_pos: Vector2i) -> Vector2:
	return Vector2(
		GRID_X + grid_pos.x * CELL_SIZE + CELL_SIZE / 2,
		GRID_Y + grid_pos.y * CELL_SIZE + CELL_SIZE / 2
	)


func get_bus_x(index: int) -> float:
	return 15.0 + index * (BUS_WIDTH + BUS_GAP)


func get_bus_rect(index: int) -> Rect2:
	var x := get_bus_x(index)

	x += buses[index].offset_x

	return Rect2(
		x,
		BUS_Y,
		BUS_WIDTH,
		BUS_HEIGHT
	)


func get_bus_passenger_position(
	bus_index: int,
	passenger_index: int
) -> Vector2:

	var rect := get_bus_rect(bus_index)

	var spacing := 22.0

	return Vector2(
		rect.position.x + 20 + passenger_index * spacing,
		rect.position.y + 30
	)


# ==========================================
# INPUT
# ==========================================

func _input(event):

	var input_position := game_input.handle_input(event)

	if not game_input.has_input(input_position):
		return

	if busy:
		return

	if game_won:
		return

	if game_over:
		return

	handle_click(input_position)


# ==========================================
# CLICK
# ==========================================

func handle_click(position: Vector2):

	# -----------------------------
	# Passenger
	# -----------------------------

	for i in range(passengers.size()):

		var passenger = passengers[i]

		if not passenger.active:
			continue

		if passenger.moving:
			continue

		if position.distance_to(
			passenger.position
		) <= PASSENGER_RADIUS + 8:

			select_passenger(i)
			return


	# -----------------------------
	# Bus
	# -----------------------------

	if selected_passenger < 0:
		return

	for i in range(buses.size()):

		var bus = buses[i]

		if not bus.active:
			continue

		var rect := get_bus_rect(i)

		if rect.has_point(position):

			try_board_bus(i)
			return


# ==========================================
# PASSENGER SELECTION
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

	var color_index: int = passengers[index].color

	game_ui.update_info(
		"Valittu: %s. Valitse oikea bussi."
		% get_color_name(color_index)
	)

	queue_redraw()


# ==========================================
# BOARDING
# ==========================================

func try_board_bus(bus_index: int):

	if selected_passenger < 0:
		return

	if bus_index < 0:
		return

	if bus_index >= buses.size():
		return

	var passenger = passengers[selected_passenger]
	var bus = buses[bus_index]

	if not passenger.active:
		selected_passenger = -1
		return

	if passenger.moving:
		return

	if not bus.active:
		return

	if bus.departing:
		return

	# -----------------------------
	# WRONG BUS
	# -----------------------------

	if passenger.color != bus.color:

		lives -= 1

		if lives < 0:
			lives = 0

		game_ui.update_lives(lives)

		game_ui.update_info(
			"❌ Väärä bussi! Elämät: %d" % lives
		)

		selected_passenger = -1

		if lives <= 0:
			game_over = true
			game_ui.update_info("💥 PELI OHI!")

		queue_redraw()

		return


	# -----------------------------
	# BUS FULL
	# -----------------------------

	if bus.filled >= bus.capacity:

		game_ui.update_info(
			"🚌 Bussi on täynnä!"
		)

		selected_passenger = -1

		queue_redraw()

		return


	# -----------------------------
	# CORRECT BUS
	# -----------------------------

	busy = true

	passenger.moving = true

	bus.filled += 1
	bus.passengers.append(passenger.color)

	score += 10

	game_ui.update_score(score)

	var target_position := get_bus_passenger_position(
		bus_index,
		bus.filled - 1
	)

	var start_position: Vector2 = passenger.position

	var tween := create_tween()

	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_IN_OUT)

	tween.tween_method(
		func(value: Vector2):

			if selected_passenger >= 0:
				passengers[selected_passenger].position = value

			queue_redraw(),

		start_position,
		target_position,
		MOVE_TIME
	)

	await tween.finished

	passenger.active = false
	passenger.moving = false

	selected_passenger = -1
	busy = false

	game_ui.update_info(
		"✅ Matkustaja nousi bussiin! +10 pistettä"
	)

	queue_redraw()

	# -----------------------------
	# FULL BUS
	# -----------------------------

	if bus.filled >= bus.capacity:
		depart_bus(bus_index)


	# -----------------------------
	# WIN
	# -----------------------------

	check_win()


# ==========================================
# BUS DEPARTURE
# ==========================================

func depart_bus(bus_index: int):

	if bus_index < 0:
		return

	if bus_index >= buses.size():
		return

	var bus = buses[bus_index]

	if not bus.active:
		return

	if bus.departing:
		return

	if bus.filled < bus.capacity:
		return

	bus.departing = true

	busy = true

	game_ui.update_info(
		"🚌 Bussi lähtee!"
	)

	var start_offset: float = bus.offset_x
	var target_offset: float = 500.0

	var tween := create_tween()

	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_IN)

	tween.tween_method(
		func(value: float):

			bus.offset_x = value

			queue_redraw(),

		start_offset,
		target_offset,
		0.7
	)

	await tween.finished

	bus.active = false
	bus.departing = false
	bus.offset_x = 0.0

	busy = false

	game_ui.update_info(
		"Valitse seuraava matkustaja."
	)

	queue_redraw()


# ==========================================
# WIN
# ==========================================

func check_win():

	for passenger in passengers:

		if passenger.active:
			return

	game_won = true
	busy = false

	game_ui.update_info(
		"🎉 VOITIT! Pisteet: %d" % score
	)

	queue_redraw()


# ==========================================
# RESTART
# ==========================================

func restart_game():

	create_level()

	game_ui.update_info(
		"Valitse matkustaja ja sitten oikea bussi."
	)

	queue_redraw()


# ==========================================
# INFO
# ==========================================

func get_color_name(color_index: int) -> String:

	match color_index:

		0:
			return "punainen"

		1:
			return "sininen"

		2:
			return "vihreä"

		3:
			return "keltainen"

		_:
			return "tuntematon"


# ==========================================
# DRAW
# ==========================================

func _draw():

	# -----------------------------
	# Background
	# -----------------------------

	draw_rect(
		Rect2(
			0,
			0,
			480,
			850
		),
		Color("#ECEFF1")
	)


	# -----------------------------
	# Board
	# -----------------------------

	for y in range(ROWS):

		for x in range(COLS):

			var rect := Rect2(
				GRID_X + x * CELL_SIZE,
				GRID_Y + y * CELL_SIZE,
				CELL_SIZE - 4,
				CELL_SIZE - 4
			)

			draw_rect(
				rect,
				Color("#CFD8DC")
			)

			draw_rect(
				rect,
				Color("#90A4AE"),
				false,
				2.0
			)


	# -----------------------------
	# Passengers
	# -----------------------------

	for i in range(passengers.size()):

		var passenger = passengers[i]

		if not passenger.active:
			continue

		var passenger_color := get_draw_color(
			passenger.color
		)

		var radius := PASSENGER_RADIUS

		if i == selected_passenger:
			draw_circle(
				passenger.position,
				radius + 7,
				Color("#FFFFFF")
			)

			draw_arc(
				passenger.position,
				radius + 7,
				0,
				TAU,
				32,
				Color("#212121"),
				3.0
			)

		draw_circle(
			passenger.position,
			radius,
			passenger_color
		)

		draw_circle(
			passenger.position,
			radius,
			Color("#263238"),
			false,
			2.0
		)


	# -----------------------------
	# Buses
	# -----------------------------

	for i in range(buses.size()):

		var bus = buses[i]

		if not bus.active:
			continue

		var rect := get_bus_rect(i)

		var bus_color := get_draw_color(
			bus.color
		)

		draw_rect(
			rect,
			bus_color
		)

		draw_rect(
			rect,
			Color("#263238"),
			false,
			3.0
		)

		# Bus windows

		draw_rect(
			Rect2(
				rect.position.x + 10,
				rect.position.y + 8,
				80,
				22
			),
			Color("#ECEFF1")
		)

		# Wheels

		draw_circle(
			Vector2(
				rect.position.x + 20,
				rect.position.y + 70
			),
			10,
			Color("#263238")
		)

		draw_circle(
			Vector2(
				rect.position.x + 80,
				rect.position.y + 70
			),
			10,
			Color("#263238")
		)

		# Filled count

		var filled_text := "%d/%d" % [
			bus.filled,
			bus.capacity
		]

		var font := ThemeDB.fallback_font

		draw_string(
			font,
			Vector2(
				rect.position.x + 35,
				rect.position.y + 55
			),
			filled_text,
			HORIZONTAL_ALIGNMENT_LEFT,
			-1,
			16,
			Color("#FFFFFF")
		)


# ==========================================
# DRAW COLORS
# ==========================================

func get_draw_color(color_index: int) -> Color:

	match color_index:

		0:
			return Color("#EF5350")

		1:
			return Color("#42A5F5")

		2:
			return Color("#66BB6A")

		3:
			return Color("#FFCA28")

		_:
			return Color("#9E9E9E")