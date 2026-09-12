extends Node

# ==========================================
# BUS MATCH OUT
# GAME EVENTS
# ==========================================
# Pelin tapahtumien nimet keskitetysti
# ==========================================


# ==========================================
# EVENT NAMES
# ==========================================

const PASSENGER_SELECTED := "passenger_selected"

const PASSENGER_BOARDING := "passenger_boarding"

const PASSENGER_BOARDED := "passenger_boarded"

const WRONG_BUS := "wrong_bus"

const BUS_FULL := "bus_full"

const BUS_DEPARTING := "bus_departing"

const BUS_DEPARTED := "bus_departed"

const LEVEL_WON := "level_won"

const GAME_OVER := "game_over"

const GAME_RESTARTED := "game_restarted"


# ==========================================
# GET ALL EVENTS
# ==========================================

func get_all_events() -> Array:

        return [
                PASSENGER_SELECTED,
                PASSENGER_BOARDING,
                PASSENGER_BOARDED,
                WRONG_BUS,
                BUS_FULL,
                BUS_DEPARTING,
                BUS_DEPARTED,
                LEVEL_WON,
                GAME_OVER,
                GAME_RESTARTED
        ]


# ==========================================
# IS GAME END EVENT
# ==========================================

func is_game_end_event(
        event_name: String
) -> bool:

        return (
                event_name == LEVEL_WON
                or
                event_name == GAME_OVER
        )


# ==========================================
# IS BUS EVENT
# ==========================================

func is_bus_event(
        event_name: String
) -> bool:

        return (
                event_name == BUS_FULL
                or
                event_name == BUS_DEPARTING
                or
                event_name == BUS_DEPARTED
        )


# ==========================================
# IS PASSENGER EVENT
# ==========================================

func is_passenger_event(
        event_name: String
) -> bool:

        return (
                event_name == PASSENGER_SELECTED
                or
                event_name == PASSENGER_BOARDING
                or
                event_name == PASSENGER_BOARDED
        )