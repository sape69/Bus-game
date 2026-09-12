extends Node

# ==========================================
# BUS MATCH OUT
# PASSENGER SELECTION
# ==========================================
# Matkustajan valinnan hallinta
# ==========================================


# ==========================================
# FIND PASSENGER
# ==========================================

func find_passenger(
        passengers: Array,
        position: Vector2,
        radius: float
) -> int:

        for i in range(passengers.size()):

                var passenger = passengers[i]

                if not passenger.active:
                        continue

                if passenger.moving:
                        continue

                var passenger_position: Vector2 = (
                        passenger.position
                )

                if position.distance_to(
                        passenger_position
                ) <= radius + 8:

                        return i

        return -1


# ==========================================
# SELECT PASSENGER
# ==========================================

func select(
        passengers: Array,
        index: int
) -> int:

        if index < 0:
                return -1

        if index >= passengers.size():
                return -1

        if not passengers[index].active:
                return -1

        if passengers[index].moving:
                return -1

        return index


# ==========================================
# CLEAR SELECTION
# ==========================================

func clear_selection() -> int:

        return -1


# ==========================================
# HAS SELECTION
# ==========================================

func has_selection(
        selected_index: int
) -> bool:

        return selected_index >= 0


# ==========================================
# GET SELECTED
# ==========================================

func get_selected(
        passengers: Array,
        selected_index: int
):

        if selected_index < 0:
                return null

        if selected_index >= passengers.size():
                return null

        return passengers[selected_index]