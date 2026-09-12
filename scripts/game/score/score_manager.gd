extends Node

# ==========================================
# BUS MATCH OUT
# SCORE MANAGER
# ==========================================
# Pelin pisteiden hallinta
# ==========================================


# ==========================================
# DEFAULT SCORE
# ==========================================

const BOARDING_SCORE := 10


# ==========================================
# ADD SCORE
# ==========================================

func add_score(
        current_score: int,
        amount: int
) -> int:

        return current_score + amount


# ==========================================
# PASSENGER BOARDING SCORE
# ==========================================

func get_boarding_score() -> int:

        return BOARDING_SCORE


# ==========================================
# RESET SCORE
# ==========================================

func reset_score() -> int:

        return 0


# ==========================================
# GET SCORE TEXT
# ==========================================

func get_score_text(
        score: int
) -> String:

        return "⭐ Pisteet: %d" % score