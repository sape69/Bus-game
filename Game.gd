extends Node2D

# ==========================================
# BUS MATCH OUT - PROTOTYPE
# ==========================================

const COLS := 5
const ROWS := 5

const CELL_SIZE := 65.0
const GRID_X := 20.0
const GRID_Y := 100.0

const BUS_Y := 650.0
const BUS_WIDTH := 150.0
const BUS_HEIGHT := 80.0

var colors := [
	Color("#ef5350"), # punainen
	Color("#42a5f5"), # sininen
	Color("#66bb6a"), # vihreä
	Color("#ffca28")  # keltainen
]

var passengers: Array = []
var buses: Array = []

var selected_passenger := -1

var score := 0
var game_won := false

var title_label: Label
var info_label: Label
var restart_button: Button


func _ready():
	create_ui()
	create_level()
	queue_redraw()


# ==========================================
# UI
# ==========================================

func create_ui():

	title_label = Label.new()
	title_label.text = "BUS MATCH"
	title_label.position = Vector2(20, 20)

	title_label.add_theme_font_size_override(
		"font_size",
		32
	)

	add_child(title_label)


	info_label = Label.new()
	info_label.position = Vector2(20, 60)

	info_label.add_theme_font_size_override(
		"font_size",
		20
	)

	add_child(info_label)


	restart_button = Button.new()
	restart_button.text = "UUDELLEEN"

	restart_button.position = Vector2(
		200,
		750
	)

	restart_button.size = Vector2(
		180,
		60
	)

	restart_button.add_theme_font_size_override(
		"font_size",
		20
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
	selected_passenger = -1
	game_won = false


	# --------------------------------------
	# MATKUSTAJAT
	# --------------------------------------

	var passenger_colors := [
		0, 0, 0,
		1, 1, 1,
		2, 2, 2,
		3, 3, 3,
		0, 1, 2, 3
	]

	passenger_colors.shuffle()


	var index := 0

	for y in range(ROWS):
		for x in range(COLS):

			var passenger := {
				"grid": Vector2i(x, y),
				"color": passenger_colors[index],
				"active": true
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
			"filled": 0
		}

		buses.append(bus)


	update_info()


# ==========================================
# INPUT
# ==========================================

func _input(event):

	if game_won:
		return


	# Hiiren painallus
	if event is InputEventMouseButton:

		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				handle_click(event.position)


	# Kosketus puhelimella
	if event is InputEventScreenTouch:

		if event.pressed:
			handle_click(event.position)


# ==========================================
# CLICK
# ==========================================

func handle_click(pos: Vector2):

	# --------------------------------------
	# Tarkista matkustajat
	# --------------------------------------

	for i in range(passengers.size()):

		var passenger = passengers[i]

		if not passenger.active:
			continue


		var grid_pos: Vector2i = passenger.grid

		var center := Vector2(
			GRID_X +
			grid_pos.x * CELL_SIZE +
			CELL_SIZE / 2,

			GRID_Y +
			grid_pos.y * CELL_SIZE +
			CELL_SIZE / 2
		)


		if pos.distance_to(center) < CELL_SIZE * 0.45:

			select_passenger(i)
			return


	# --------------------------------------
	# Tarkista bussit
	# --------------------------------------

	for i in range(buses.size()):

		var bus_x := 20.0 + i * 160.0

		var rect := Rect2(
			bus_x,
			BUS_Y,
			BUS_WIDTH,
			BUS_HEIGHT
		)


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

	var passenger = passengers[passenger_index]
	var bus = buses[bus_index]


	# Väärä väri
	if passenger.color != bus.color:

		info_label.text = "❌ Väärän värinen bussi!"

		return


	# Bussi täynnä
	if bus.filled >= bus.capacity:

		info_label.text = "🚌 Bussi on täynnä!"

		return


	# Oikea bussi
	passenger.active = false

	bus.filled += 1

	score += 10

	selected_passenger = -1


	# Jos bussi täyttyy
	if bus.filled >= bus.capacity:

		info_label.text = "🚌 Bussi lähti!"


	# Tarkista voitto
	check_win()

	update_info()

	queue_redraw()


# ==========================================
# WIN
# ==========================================

func check_win():

	for passenger in passengers:

		if passenger.active:
			return


	game_won = true

	info_label.text = "🎉 TASO SUORITETTU! 🎉"

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

	if game_won:

		info_label.text = "🎉 VOITIT! Pisteet: %d" % score

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
			"Valittu matkustaja: %s | Jäljellä: %d"
			% [
				get_color_name(color_index),
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

func get_color_name(index: int) -> String:

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

	# Tausta
	draw_rect(
		Rect2(
			0,
			0,
			480,
			850
		),
		Color("#101820")
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

				CELL_SIZE - 3,
				CELL_SIZE - 3
			)


			draw_rect(
				rect,
				Color("#263238"),
				true
			)


			draw_rect(
				rect,
				Color("#455a64"),
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


		var grid_pos: Vector2i = passenger.grid

		var center := Vector2(
			GRID_X +
			grid_pos.x * CELL_SIZE +
			CELL_SIZE / 2,

			GRID_Y +
			grid_pos.y * CELL_SIZE +
			CELL_SIZE / 2
		)


		# Valittu matkustaja
		if i == selected_passenger:

			draw_circle(
				center,
				29,
				Color.WHITE
			)


		draw_circle(
			center,
			22,
			colors[passenger.color]
		)


		# Pään pieni valkoinen piste
		draw_circle(
			center + Vector2(0, -6),
			6,
			Color.WHITE
		)


	# --------------------------------------
	# BUSSIT
	# --------------------------------------

	for i in range(buses.size()):

		draw_bus(
			i
		)


# ==========================================
# DRAW BUS
# ==========================================

func draw_bus(index: int):

	var bus = buses[index]

	var x := 20.0 + index * 160.0

	var rect := Rect2(
		x,
		BUS_Y,
		BUS_WIDTH,
		BUS_HEIGHT
	)


	# Bussi
	draw_rect(
		rect,
		colors[bus.color],
		true
	)


	# Ikkuna
	draw_rect(
		Rect2(
			x + 15,
			BUS_Y + 12,
			120,
			30
		),
		Color("#263238"),
		true
	)


	# Pyörät
	draw_circle(
		Vector2(
			x + 35,
			BUS_Y + BUS_HEIGHT
		),
		12,
		Color("#111111")
	)


	draw_circle(
		Vector2(
			x + 115,
			BUS_Y + BUS_HEIGHT
		),
		12,
		Color("#111111")
	)


	# Matkustajamäärä
	var font := ThemeDB.fallback_font

	draw_string(
		font,
		Vector2(
			x + 55,
			BUS_Y + 65
		),
		"%d / %d" % [
			bus.filled,
			bus.capacity
		],
		HORIZONTAL_ALIGNMENT_LEFT,
		-1,
		18,
		Color.WHITE
	)
