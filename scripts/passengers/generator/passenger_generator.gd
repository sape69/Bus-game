extends Node

# ==========================================
# BUS MATCH OUT
# PASSENGER GENERATOR
# ==========================================
# Luo matkustajien perustiedot tasoa varten
# ==========================================


# ==========================================
# CREATE PASSENGERS
# ==========================================

func create_passengers(
        cols: int,
        rows: int,
        passenger_colors: Array,
        cell_position_callback: Callable
) -> Array:

        var result: Array = []

        var index := 0


        for y in range(rows):

                for x in range(cols):

                        if index >= passenger_colors.size():
                                break


                        var passenger := {
                                "grid": Vector2i(
                                        x,
                                        y
                                ),

                                "color": passenger_colors[
                                        index
                                ],

                                "active": true,

                                "moving": false,

                                "position": cell_position_callback.call(
                                        Vector2i(
                                                x,
                                                y
                                        )
                                )
                        }


                        result.append(
                                passenger
                        )

                        index += 1


        return result


# ==========================================
# SHUFFLE COLORS
# ==========================================

func shuffle_colors(
        passenger_colors: Array
) -> Array:

        var result := passenger_colors.duplicate()

        result.shuffle()

        return result