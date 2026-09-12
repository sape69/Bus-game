extends Node

# ==========================================
# BUS MATCH OUT
# GAME MESSAGES
# ==========================================
# Pelin ilmoitukset ja viestit
# ==========================================


# ==========================================
# DEFAULT MESSAGE
# ==========================================

func get_default_message(
        remaining: int
) -> String:

        return (
                "Valitse matkustaja | Jäljellä: %d"
                % remaining
        )


# ==========================================
# SELECTED MESSAGE
# ==========================================

func get_selected_message(
        color_name: String,
        remaining: int
) -> String:

        return (
                "Valittu: %s | Jäljellä: %d"
                % [
                        color_name,
                        remaining
                ]
        )


# ==========================================
# WRONG BUS
# ==========================================

func get_wrong_bus_message() -> String:

        return "❌ Väärä bussi!"


# ==========================================
# BUS FULL
# ==========================================

func get_bus_full_message() -> String:

        return "🚌 Bussi on täynnä!"


# ==========================================
# BUS DEPARTING
# ==========================================

func get_bus_departing_message() -> String:

        return "🚌 Bussi lähtee!"


# ==========================================
# LEVEL COMPLETE
# ==========================================

func get_level_complete_message() -> String:

        return "🎉 TASO SUORITETTU!"


# ==========================================
# WIN
# ==========================================

func get_win_message(
        score: int
) -> String:

        return (
                "🎉 VOITIT! Pisteet: %d"
                % score
        )


# ==========================================
# GAME OVER
# ==========================================

func get_game_over_message() -> String:

        return "💥 PELI OHI!"


# ==========================================
# RESTART
# ==========================================

func get_restart_message() -> String:

        return "🔄 UUDELLEEN"