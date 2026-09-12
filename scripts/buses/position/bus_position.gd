extends Node

# ==========================================
# BUS MATCH OUT
# BUS POSITION
# ==========================================
# Bussien sijaintien laskenta
# ==========================================


# ==========================================
# BUS SETTINGS
# ==========================================

const BUS_Y := 665.0

const BUS_WIDTH := 100.0

const BUS_HEIGHT := 70.0

const BUS_GAP := 15.0


# ==========================================
# GET BUS X
# ==========================================

func get_bus_x(
        index: int
) -> float:

        return 15.0 + index * (
                BUS_WIDTH + BUS_GAP
        )


# ==========================================
# GET BUS RECT
# ==========================================

func get_bus_rect(
        index: int,
        offset_x: float = 0.0
) -> Rect2:

        var x := get_bus_x(index)

        x += offset_x

        return Rect2(
                x,
                BUS_Y,
                BUS_WIDTH,
                BUS_HEIGHT
        )


# ==========================================
# GET PASSENGER POSITION
# ==========================================

func get_passenger_position(
        bus_index: int,
        passenger_index: int,
        offset_x: float = 0.0
) -> Vector2:

        var rect := get_bus_rect(
                bus_index,
                offset_x
        )

        var spacing := 22.0

        return Vector2(
                rect.position.x +
                20 +
                passenger_index * spacing,

                rect.position.y +
                30
        )


# ==========================================
# GET BUS WIDTH
# ==========================================

func get_bus_width() -> float:

        return BUS_WIDTH


# ==========================================
# GET BUS HEIGHT
# ==========================================

func get_bus_height() -> float:

        return BUS_HEIGHT


# ==========================================
# GET BUS Y
# ==========================================

func get_bus_y() -> float:

        return BUS_Y