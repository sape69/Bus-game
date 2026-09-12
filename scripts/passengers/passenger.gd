extends Node

# ==========================================
# BUS MATCH OUT
# PASSENGER
# ==========================================
# Yhden matkustajan tiedot ja perustoiminnot
# ==========================================


# ==========================================
# PASSENGER DATA
# ==========================================

var grid_position := Vector2i.ZERO

var color_index := 0

var active := true

var moving := false

var position := Vector2.ZERO


# ==========================================
# SETUP
# ==========================================

func setup(
        grid_pos: Vector2i,
        passenger_color: int,
        passenger_position: Vector2
):

        grid_position = grid_pos

        color_index = passenger_color

        position = passenger_position

        active = true

        moving = false


# ==========================================
# SELECT
# ==========================================

func select():

        if not active:
                return

        if moving:
                return


# ==========================================
# START MOVEMENT
# ==========================================

func start_moving():

        if not active:
                return

        moving = true


# ==========================================
# FINISH MOVEMENT
# ==========================================

func finish_moving():

        moving = false

        active = false


# ==========================================
# IS AVAILABLE
# ==========================================

func is_available() -> bool:

        if not active:
                return false

        if moving:
                return false

        return true


# ==========================================
# GET COLOR
# ==========================================

func get_color() -> int:

        return color_index


# ==========================================
# GET GRID POSITION
# ==========================================

func get_grid_position() -> Vector2i:

        return grid_position


# ==========================================
# GET POSITION
# ==========================================

func get_position() -> Vector2:

        return position


# ==========================================
# SET POSITION
# ==========================================

func set_position(
        new_position: Vector2
):

        position = new_position