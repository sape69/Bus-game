extends Node

# ==========================================
# BUS MATCH OUT
# BOARD RENDERER
# ==========================================
# Pelilaudan, matkustajien ja bussien piirtäminen
# ==========================================


func draw_game(
	canvas: Node2D,
	passengers: Array,
	buses: Array,
	selected_passenger: int,
	colors: Array,
	dark_background: Color,
	grid_color: Color,
	grid_border: Color,
	white: Color,
	dark: Color,
	cols: int,
	rows: int,
	cell_size: float,
	grid_x: float,
	grid_y: float,
	get_bus_rect_callback: Callable
) -> void:

	if canvas == null:
		return

	# --------------------------------------
	# TAUSTA
	# --------------------------------------

	canvas.draw_rect(
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

	canvas.draw_rect(
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

	for y in range(rows):

		for x in range(cols):

			var rect := Rect2(
				grid_x + x * cell_size,
				grid_y + y * cell_size,
				cell_size - 4,
				cell_size - 4
			)

			canvas.draw_rect(
				rect,
				grid_color,
				true
			)

			canvas.draw_rect(
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

			canvas.draw_circle(
				center,
				29,
				Color("#ffffff")
			)

			canvas.draw_arc(
				center,
				31,
				0,
				TAU,
				32,
				colors[passenger.color],
				4
			)


		# Keho

		canvas.draw_circle(
			center,
			22,
			colors[passenger.color]
		)


		# Pää

		canvas.draw_circle(
			center + Vector2(0, -8),
			7,
			white
		)


		# Silmät

		canvas.draw_circle(
			center + Vector2(-3, -9),
			1.5,
			dark
		)

		canvas.draw_circle(
			center + Vector2(3, -9),
			1.5,
			dark
		)


	# --------------------------------------
	# BUSSIT
	# --------------------------------------

	for i in range(buses.size()):

		if not buses[i].active:
			continue

		draw_bus(
			canvas,
			buses[i],
			i,
			colors,
			white,
			dark,
			get_bus_rect_callback
		)


	# --------------------------------------
	# BUSSIALUEEN OTSIKKO
	# --------------------------------------

	canvas.draw_string(
		ThemeDB.fallback_font,
		Vector2(20, 650),
		"BUSSIT",
		HORIZONTAL_ALIGNMENT_LEFT,
		-1,
		16,
		Color("#90a4ae")
	)


func draw_bus(
	canvas: Node2D,
	bus,
	index: int,
	colors: Array,
	white: Color,
	dark: Color,
	get_bus_rect_callback: Callable
) -> void:

	if canvas == null:
		return

	if bus == null:
		return

	var rect: Rect2 = get_bus_rect_callback.call(index)

	var bus_color: Color = colors[bus.color]


	# --------------------------------------
	# VARJO
	# --------------------------------------

	canvas.draw_rect(
		Rect2(
			rect.position + Vector2(0, 5),
			rect.size
		),
		Color("#080c0e"),
		true
	)


	# --------------------------------------
	# RUNKO
	# --------------------------------------

	canvas.draw_rect(
		rect,
		bus_color,
		true
	)


	# --------------------------------------
	# YLÄREUNA
	# --------------------------------------

	canvas.draw_rect(
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


	# --------------------------------------
	# IKKUNAT
	# --------------------------------------

	canvas.draw_rect(
		Rect2(
			rect.position + Vector2(8, 14),
			Vector2(84, 22)
		),
		Color("#263238"),
		true
	)


	# --------------------------------------
	# OVI
	# --------------------------------------

	canvas.draw_rect(
		Rect2(
			rect.position + Vector2(76, 42),
			Vector2(14, 22)
		),
		Color("#37474f"),
		true
	)


	# --------------------------------------
	# PYÖRÄT
	# --------------------------------------

	canvas.draw_circle(
		Vector2(
			rect.position.x + 20,
			rect.position.y + rect.size.y
		),
		9,
		dark
	)

	canvas.draw_circle(
		Vector2(
			rect.position.x + 80,
			rect.position.y + rect.size.y
		),
		9,
		dark
	)


	# --------------------------------------
	# MATKUSTAJAT BUSSISSA
	# --------------------------------------

	for passenger_index in range(
		bus.passengers.size()
	):

		var passenger_color: Color = colors[
			bus.passengers[passenger_index]
		]

		var passenger_pos := Vector2(
			rect.position.x +
			20 +
			passenger_index * 22,

			rect.position.y +
			25
		)

		canvas.draw_circle(
			passenger_pos,
			7,
			passenger_color
		)


	# --------------------------------------
	# TÄYTTÖMÄÄRÄ
	# --------------------------------------

	canvas.draw_string(
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