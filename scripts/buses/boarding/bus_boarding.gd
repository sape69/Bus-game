extends Node

# ==========================================
# BUS MATCH OUT
# BUS BOARDING
# ==========================================
# Matkustajan sijoittaminen bussiin
# ==========================================


# ==========================================
# ADD PASSENGER
# ==========================================

func add_passenger(
        bus,
        passenger_color: int
) -> bool:

        if bus == null:
                return false

        if not bus.active:
                return false

        if bus.departing:
                return false

        if bus.filled >= bus.capacity:
                return false

        if passenger_color != bus.color:
                return false

        bus.filled += 1

        bus.passengers.append(
                passenger_color
        )

        return true


# ==========================================
# CAN BOARD
# ==========================================

func can_board(
        bus,
        passenger_color: int
) -> bool:

        if bus == null:
                return false

        if not bus.active:
                return false

        if bus.departing:
                return false

        if bus.filled >= bus.capacity:
                return false

        if passenger_color != bus.color:
                return false

        return true


# ==========================================
# IS FULL
# ==========================================

func is_full(
        bus
) -> bool:

        if bus == null:
                return false

        return bus.filled >= bus.capacity


# ==========================================
# GET FILLED
# ==========================================

func get_filled(
        bus
) -> int:

        if bus == null:
                return 0

        return bus.filled


# ==========================================
# GET CAPACITY
# ==========================================

func get_capacity(
        bus
) -> int:

        if bus == null:
                return 0

        return bus.capacity