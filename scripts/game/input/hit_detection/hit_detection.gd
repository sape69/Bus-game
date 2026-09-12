extends Node

# ==========================================
# BUS MATCH OUT
# HIT DETECTION
# ==========================================
# Tunnistaa osuuko käyttäjän painallus
# matkustajaan tai bussiin
# ==========================================


# ==========================================
# PASSENGER HIT
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
# BUS HIT
# ==========================================

func find_bus(
        buses: Array,
        position: Vector2,
        get_rect_callback: Callable
) -> int:

        for i in range(buses.size()):

                var bus = buses[i]

                if not bus.active:
                        continue

                var rect: Rect2 = (
                        get_rect_callback.call(i)
                )

                if rect.has_point(position):

                        return i

        return -1


# ==========================================
# IS PASSENGER HIT
# ==========================================

func is_passenger_hit(
        passenger,
        position: Vector2,
        radius: float
) -> bool:

        if passenger == null:
                return false

        if not passenger.active:
                return false

        if passenger.moving:
                return false

        return position.distance_to(
                passenger.position
        ) <= radius + 8


# ==========================================
# IS BUS HIT
# ==========================================

func is_bus_hit(
        bus,
        position: Vector2,
        rect: Rect2
) -> bool:

        if bus == null:
                return false

        if not bus.active:
                return false

        return rect.has_point(
                position
        )