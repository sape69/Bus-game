extends Node2D

func _ready():
	print("================================")
	print("BUS MATCH STARTED")
	print("GAME.GD IS WORKING")
	print("================================")

	queue_redraw()


func _draw():
	# Tausta
	draw_rect(
		Rect2(0, 0, 480, 850),
		Color("#ECEFF1")
	)

	# Otsikko
	var font := ThemeDB.fallback_font

	draw_string(
		font,
		Vector2(20, 50),
		"BUS MATCH",
		HORIZONTAL_ALIGNMENT_LEFT,
		-1,
		32,
		Color("#263238")
	)

	# Testiteksti
	draw_string(
		font,
		Vector2(20, 100),
		"GAME.GD TOIMII",
		HORIZONTAL_ALIGNMENT_LEFT,
		-1,
		24,
		Color("#2E7D32")
	)

	# Testilaatikko
	draw_rect(
		Rect2(20, 140, 440, 100),
		Color("#CFD8DC")
	)

	draw_rect(
		Rect2(20, 140, 440, 100),
		Color("#455A64"),
		false,
		3.0
	)

	draw_string(
		font,
		Vector2(45, 200),
		"STARTUP TEST OK",
		HORIZONTAL_ALIGNMENT_LEFT,
		-1,
		26,
		Color("#263238")
	)