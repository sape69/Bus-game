extends Node

# ==========================================
# BUS MATCH OUT
# BUS DEPARTURE
# ==========================================
# Täyden bussin lähtölogiikka
# ==========================================


# ==========================================
# CAN DEPART
# ==========================================

func can_depart(
        bus
) -> bool:

        if bus == null:
                return false

        if not bus.active:
                return false

        if bus.departing:
                return false

        if bus.filled < bus.capacity:
                return false

        return true


# ==========================================
# START DEPARTURE
# ==========================================

func start_departure(
        bus
) -> bool:

        if not can_depart(bus):
                return false

        bus.departing = true

        return true


# ==========================================
# UPDATE OFFSET
# ==========================================

func update_offset(
        bus,
        value: float
):

        if bus == null:
                return

        bus.offset_x = value


# ==========================================
# FINISH DEPARTURE
# ==========================================

func finish_departure(
        bus
):

        if bus == null:
                return

        bus.active = false

        bus.departing = false

        bus.offset_x = 0.0


# ==========================================
# RESET DEPARTURE
# ==========================================

func reset_departure(
        bus
):

        if bus == null:
                return

        bus.departing = false

        bus.offset_x = 0.0