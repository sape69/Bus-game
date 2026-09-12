extends Node

# ==========================================
# BUS MATCH OUT
# PASSENGER POSITION
# ==========================================
# Matkustajien sijaintien hallinta
# ==========================================


const CELL_SIZE := 65.0
const GRID_X := 20.0
const GRID_Y := 125.0


# ==========================================
# GRID POSITION
# ==========================================

func get_position(
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
# CELL RECT
# ==========================================

func get_cell_rect(
	grid_pos: Vector2i
) -> Rect2:

	return Rect2(
		GRID_X +
		grid_pos.x * CELL_SIZE,

		GRID_Y +
		grid_pos.y * CELL_SIZE,

		CELL_SIZE - 4,
		CELL_SIZE - 4
	)


# ==========================================
# VALUES
# ==========================================

func get_cell_size() -> float:
	return CELL_SIZE


func get_grid_x() -> float:
	return GRID_X


func get_grid_y() -> float:
	return GRID_Y