extends Node

# ==========================================
# BUS MATCH OUT
# PASSENGER POSITION
# ==========================================
# Matkustajien ruutu- ja näyttösijainnit
# ==========================================


# ==========================================
# BOARD SETTINGS
# ==========================================

const CELL_SIZE := 65.0

const GRID_X := 20.0

const GRID_Y := 125.0


# ==========================================
# GET POSITION
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
# GET CELL RECT
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
# GET CELL SIZE
# ==========================================

func get_cell_size() -> float:

        return CELL_SIZE


# ==========================================
# GET GRID X
# ==========================================

func get_grid_x() -> float:

        return GRID_X


# ==========================================
# GET GRID Y
# ==========================================

func get_grid_y() -> float:

        return GRID_Y