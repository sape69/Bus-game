extends Node

# ==========================================
# BUS MATCH OUT
# BUS
# ==========================================
# Yhden bussin tiedot ja perustoiminnot
# ==========================================


# ==========================================
# BUS DATA
# ==========================================

var color_index := 0

var capacity := 4

var filled := 0

var active := true

var departing := false

var offset_x := 0.0

var passengers: Array = []


# ==========================================
# SETUP
# ==========================================

func setup(
        bus_color: int,
        bus_capacity: int = 4
):

        color_index = bus_color

        capacity = bus_capacity

        filled = 0

        active = true

        departing = false

        offset_x = 0.0

        passengers.clear()


# ==========================================
# ADD PASSENGER
# ==========================================

func add_passenger(
        passenger_color: int
) -> bool:

        if not active:
                return false

        if departing:
                return false

        if is_full():
                return false

        if passenger_color != color_index:
                return false

        passengers.append(
                passenger_color
        )

        filled += 1

        return true


# ==========================================
# IS FULL
# ==========================================

func is_full() -> bool:

        return filled >= capacity


# ==========================================
# CAN ACCEPT PASSENGER
# ==========================================

func can_accept(
        passenger_color: int
) -> bool:

        if not active:
                return false

        if departing:
                return false

        if is_full():
                return false

        if passenger_color != color_index:
                return false

        return true


# ==========================================
# START DEPARTURE
# ==========================================

func start_departure():

        if not active:
                return

        if departing:
                return

        if not is_full():
                return

        departing = true


# ==========================================
# FINISH DEPARTURE
# ==========================================

func finish_departure():

        active = false

        departing = false

        offset_x = 0.0


# ==========================================
# RESET
# ==========================================

func reset():

        filled = 0

        active = true

        departing = false

        offset_x = 0.0

        passengers.clear()


# ==========================================
# GET COLOR
# ==========================================

func get_color() -> int:

        return color_index


# ==========================================
# GET CAPACITY
# ==========================================

func get_capacity() -> int:

        return capacity


# ==========================================
# GET FILLED
# ==========================================

func get_filled() -> int:

        return filled


# ==========================================
# GET OFFSET
# ==========================================

func get_offset_x() -> float:

        return offset_x


# ==========================================
# SET OFFSET
# ==========================================

func set_offset_x(
        value: float
):

        offset_x = value