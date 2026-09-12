extends Node

# ==========================================
# BUS MATCH OUT
# LIVES MANAGER
# ==========================================
# Pelin elämien hallinta
# ==========================================


# ==========================================
# DEFAULT LIVES
# ==========================================

const DEFAULT_LIVES := 3


# ==========================================
# RESET
# ==========================================

func reset() -> int:

        return DEFAULT_LIVES


# ==========================================
# REMOVE LIFE
# ==========================================

func remove_life(
        current_lives: int
) -> int:

        var lives := current_lives - 1

        if lives < 0:
                lives = 0

        return lives


# ==========================================
# HAS LIVES
# ==========================================

func has_lives(
        current_lives: int
) -> bool:

        return current_lives > 0


# ==========================================
# IS GAME OVER
# ==========================================

func is_game_over(
        current_lives: int
) -> bool:

        return current_lives <= 0


# ==========================================
# GET LIVES TEXT
# ==========================================

func get_lives_text(
        current_lives: int
) -> String:

        return "❤️ Elämät: %d" % current_lives