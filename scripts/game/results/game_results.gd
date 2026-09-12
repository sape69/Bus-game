extends Node

# ==========================================
# BUS MATCH OUT
# GAME RESULTS
# ==========================================
# Voiton ja häviön käsittely
# ==========================================


# ==========================================
# CHECK WIN
# ==========================================

func check_win(
        passengers: Array
) -> bool:

        for passenger in passengers:

                if passenger.active:
                        return false

        return true


# ==========================================
# CHECK GAME OVER
# ==========================================

func check_game_over(
        lives: int
) -> bool:

        return lives <= 0


# ==========================================
# WIN MESSAGE
# ==========================================

func get_win_message(
        score: int
) -> String:

        return (
                "🎉 VOITIT! Pisteet: %d"
                % score
        )


# ==========================================
# GAME OVER MESSAGE
# ==========================================

func get_game_over_message() -> String:

        return "💥 PELI OHI!"


# ==========================================
# LEVEL COMPLETE MESSAGE
# ==========================================

func get_level_complete_message() -> String:

        return "🎉 TASO SUORITETTU!"