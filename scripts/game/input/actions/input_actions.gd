extends Node

# ==========================================
# BUS MATCH OUT
# INPUT ACTIONS
# ==========================================
# Käyttäjän painalluksen kohteen käsittely
# ==========================================


# ==========================================
# FIND TARGET
# ==========================================

func find_target(
        position: Vector2,
        passengers: Array,
        buses: Array,
        passenger_radius: float,
        get_bus_rect_callback: Callable
) -> Dictionary:

        # --------------------------------------
        # PASSENGER
        # --------------------------------------

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
                ) <= passenger_radius + 8:

                        return {
                                "type": "passenger",
                                "index": i
                        }


        # --------------------------------------
        # BUS
        # --------------------------------------

        for i in range(buses.size()):

                var bus = buses[i]

                if not bus.active:
                        continue

                var rect: Rect2 = (
                        get_bus_rect_callback.call(i)
                )

                if rect.has_point(position):

                        return {
                                "type": "bus",
                                "index": i
                        }


        # --------------------------------------
        # NOTHING
        # --------------------------------------

        return {
                "type": "",
                "index": -1
        }


# ==========================================
# IS PASSENGER TARGET
# ==========================================

func is_passenger_target(
        target: Dictionary
) -> bool:

        return (
                target.get("type", "") ==
                "passenger"
        )


# ==========================================
# IS BUS TARGET
# ==========================================

func is_bus_target(
        target: Dictionary
) -> bool:

        return (
                target.get("type", "") ==
                "bus"
        )


# ==========================================
# GET TARGET INDEX
# ==========================================

func get_target_index(
        target: Dictionary
) -> int:

        return target.get(
                "index",
                -1
        )