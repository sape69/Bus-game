extends Node

# ==========================================
# BUS MATCH OUT
# BUS GENERATOR
# ==========================================
# Luo bussien perustiedot tasoa varten
# ==========================================


# ==========================================
# CREATE BUSES
# ==========================================

func create_buses(
        bus_count: int,
        bus_capacity: int
) -> Array:

        var result: Array = []


        for i in range(bus_count):

                var bus := {
                        "color": i,

                        "capacity": bus_capacity,

                        "filled": 0,

                        "active": true,

                        "departing": false,

                        "offset_x": 0.0,

                        "passengers": []
                }


                result.append(
                        bus
                )


        return result


# ==========================================
# RESET BUSES
# ==========================================

func reset_buses(
        buses: Array
) -> Array:

        for bus in buses:

                bus["filled"] = 0

                bus["active"] = true

                bus["departing"] = false

                bus["offset_x"] = 0.0

                bus["passengers"] = []


        return buses


# ==========================================
# GET BUS
# ==========================================

func get_bus(
        buses: Array,
        index: int
):

        if index < 0:
                return null

        if index >= buses.size():
                return null

        return buses[index]