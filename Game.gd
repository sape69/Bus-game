extends Node2D

# ==========================================
# BUS MATCH OUT
# ==========================================
# Ensimmäinen pelattava versio
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

var colors := [
	Color("#ef5350"), # punainen
	Color("#42a5f5"), # sininen
	Color("#66bb6a"), # vihreä
	Color("#ffca28")  # keltainen
]

var dark_background := Color("#101820")
var grid_color := Color("#263238")
var grid_border := Color("#455a64")
var white := Color("#ffffff")
var dark := Color("#111111")

var passengers: Array = []
var buses: Array = []

var selected_passenger := -1

var score := 0
var lives := 3
var game_won := false
var game_over := false
var busy := false

var title_label: Label
var info_label: Label
var score_label: Label
var lives_label: Label
var restart_button: Button


# ==========================================
# READY
# ==========================================

func _ready():

	create_ui()

	create_level()

	queue_redraw()


# ==========================================
# UI
# ==========================================

func create_ui():

	title_label = Label.new()

	title_label.text = "🚌 BUS MATCH"

	title_label.position = Vector2(
		20,
		15
	)

	title_label.add_theme_font_size_override(
		"font_size",
		30
	)

	add_child(title_label)


	score_label = Label.new()

	score_label.position = Vector2(
		20,
		65
	)

	score_label.add_theme_font_size_override(
		"font_size",
		18
	)

	add_child(score_label)


	lives_label = Label.new()

	lives_label.position = Vector2(
		330,
		65
	)

	lives_label.add_theme_font_size_override(
		"font_size",
		18
	)

	add_child(lives_label)


	info_label = Label.new()

	info_label.position = Vector2(
		20,
		95
	)

	info_label.add_theme_font_size_override(
		"font_size",
		16
	)

	add_child(info_label)


	restart_button = Button.new()

	restart_button.text = "🔄 UUDELLEEN"

	restart_button.position = Vector2(
		145,
		770
	)

	restart_button.size = Vector2(
		190,
		55
	)

	restart_button.add_theme_font_size_override(
		"font_size",
		18
	)

	restart_button.pressed.connect(
		restart_game
	)

	add_child(restart_button)


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

			var passenger := {
				"grid": Vector2i(x, y),
				"color": passenger_colors[index],
				"active": true,
				"moving": false,
				"position": get_passenger_position(
					Vector2i(x, y)
				)
			}

			passengers.append(
				passenger
			)

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

		info_label.text = (
			"❌ Väärä bussi!"
		)

		selected_passenger = -1

		update_info()

		queue_redraw()


		if lives <= 0:

			game_over = true

			info_label.text = (
				"💥 PELI OHI!"
			)

			queue_redraw()

		return


	# --------------------------------------
	# BUSSI TÄYNNÄ
	# --------------------------------------

	if bus.filled >= bus.capacity:

		info_label.text = (
			"🚌 Bussi on täynnä!"
		)

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


	var start := passenger.position


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

	var bus = buses[
		bus_index
	]


	if bus.filled < bus.capacity:
		return


	if bus.departing:
		return


	bus.departing = true

	info_label.text = (
		"🚌 Bussi lähtee!"
	)

	var start_x := get_bus_x(
		bus_index
	)

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

	if buses.size() > index:

		if buses[index].has("offset_x"):

			x += buses[index].offset_x


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

	var start_x := rect.position.x + 20

	return Vector2(
		start_x +
		passenger_index * spacing,

		rect.position.y + 30
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

	info_label.text = (
		"🎉 TASO SUORITETTU!"
	)

	queue_redraw()


# ==========================================
# RESTART
# ==========================================

func restart_game():

	create_level()

	queue_redraw()


# ==========================================
# INFO
# ==========================================

func update_info():

	score_label.text = (
		"⭐ Pisteet: %d" % score
	)


	lives_label.text = (
		"❤️ Elämät: %d" % lives
	)


	if game_won:

		info_label.text = (
			"🎉 VOITIT! Pisteet: %d"
			% score
		)

		return


	if game_over:

		info_label.text = (
			"💥 PELI OHI!"
		)

		return


	var remaining := 0


	for passenger in passengers:

		if passenger.active:

			remaining += 1


	if selected_passenger >= 0:

		var color_index = passengers[
			selected_passenger
		].color

		info_label.text = (
			"Valittu: %s | Jäljellä: %d"
			% [
				get_color_name(
					color_index
				),
				remaining
			]
		)

	else:

		info_label.text = (
			"Valitse matkustaja | Jäljellä: %d"
			% remaining
		)


# ==========================================
# COLOR NAME
# ==========================================

func get_color_name(
	index: int
) -> String:

	match index:

		0:
			return "PUNAINEN"

		1:
			return "SININEN"

		2:
			return "VIHREÄ"

		3:
			return "KELTAINEN"


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
		dark_background
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
		Color("#162329")
	)


	# --------------------------------------
	# GRID
	# --------------------------------------

	for y in range(ROWS):

		for x in range(COLS):

			var rect := Rect2(
				GRID_X +
				x * CELL_SIZE,

				GRID_Y +
				y * CELL_SIZE,

				CELL_SIZE - 4,
				CELL_SIZE - 4
			)


			draw_rect(
				rect,
				grid_color,
				true
			)


			draw_rect(
				rect,
				grid_border,
				false,
				2
			)


	# --------------------------------------
	# PASSENGERS
	# --------------------------------------

	for i in range(passengers.size()):

		var passenger = passengers[i]

		if not passenger.active:
			continue


		var center: Vector2 = passenger.position


		# Valinnan halo

		if i == selected_passenger:

			draw_circle(
				center,
				29,
				Color("#ffffff")
			)


			draw_arc(
				center,
				31,
				0,
				TAU,
				32,
				colors[
					passenger.color
				],
				4
			)


		# Keho

		draw_circle(
			center,
			22,
			colors[
				passenger.color
			]
		)


		# Pää

		draw_circle(
			center +
			Vector2(
				0,
				-8
			),
			7,
			white
		)


		# Silmät

		draw_circle(
			center +
			Vector2(
				-3,
				-9
			),
			1.5,
			dark
		)


		draw_circle(
			center +
			Vector2(
				3,
				-9
			),
			1.5,
			dark
		)


	# --------------------------------------
	# BUSSIT
	# --------------------------------------

	for i in range(buses.size()):

		if not buses[i].active:
			continue

		draw_bus(i)


	# --------------------------------------
	# ALUE BUSSEILLE
	# --------------------------------------

	draw_string(
		ThemeDB.fallback_font,
		Vector2(
			20,
			650
		),
		"BUSSIT",
		HORIZONTAL_ALIGNMENT_LEFT,
		-1,
		16,
		Color("#90a4ae")
	)


# ==========================================
# DRAW BUS
# ==========================================

func draw_bus(
	index: int
):

	var bus = buses[index]

	var rect := get_bus_rect(
		index
	)


	var bus_color = colors[
		bus.color
	]


	# Varjo

	draw_rect(
		Rect2(
			rect.position +
			Vector2(
				0,
				5
			),
			rect.size
		),
		Color("#080c0e"),
		true
	)


	# Runko

	draw_rect(
		rect,
		bus_color,
		true
	)


	# Yläreuna

	draw_rect(
		Rect2(
			rect.position,
			Vector2(
				rect.size.x,
				8
			)
		),
		Color(
			bus_color.r * 0.75,
			bus_color.g * 0.75,
			bus_color.b * 0.75
		),
		true
	)


	# Ikkunat

	draw_rect(
		Rect2(
			rect.position +
			Vector2(
				8,
				14
			),
			Vector2(
				84,
				22
			)
		),
		Color("#263238"),
		true
	)


	# Ovi

	draw_rect(
		Rect2(
			rect.position +
			Vector2(
				76,
				42
			),
			Vector2(
				14,
				22
			)
		),
		Color("#37474f"),
		true
	)


	# Pyörät

	draw_circle(
		Vector2(
			rect.position.x + 20,
			rect.position.y + rect.size.y
		),
		9,
		dark
	)


	draw_circle(
		Vector2(
			rect.position.x + 80,
			rect.position.y + rect.size.y
		),
		9,
		dark
	)


	# Matkustajat bussissa

	for passenger_index in range(
		bus.passengers.size()
	):

		var passenger_color = colors[
			bus.passengers[
				passenger_index
			]
		]


		var passenger_pos := Vector2(
			rect.position.x +
			20 +
			passenger_index * 22,

			rect.position.y +
			25
		)


		draw_circle(
			passenger_pos,
			7,
			passenger_color
		)


	# Täyttömäärä

	draw_string(
		ThemeDB.fallback_font,

		Vector2(
			rect.position.x + 34,
			rect.position.y + 58
		),

		"%d/%d" % [
			bus.filled,
			bus.capacity
		],

		HORIZONTAL_ALIGNMENT_LEFT,
		-1,
		14,
		white
	)