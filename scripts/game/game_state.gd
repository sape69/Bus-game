extends Node

# ==========================================
# BUS MATCH OUT
# GAME STATE
# ==========================================
# Pelin yleinen tila
# ==========================================


# ==========================================
# DEFAULT VALUES
# ==========================================

const DEFAULT_LIVES := 3


# ==========================================
# GAME STATE
# ==========================================

var score := 0

var lives := DEFAULT_LIVES

var game_won := false

var game_over := false

var busy := false

var selected_passenger := -1


# ==========================================
# RESET
# ==========================================

func reset():

        score = 0

        lives = DEFAULT_LIVES

        game_won = false

        game_over = false

        busy = false

        selected_passenger = -1


# ==========================================
# ADD SCORE
# ==========================================

func add_score(
        amount: int
):

        score += amount


# ==========================================
# REMOVE LIFE
# ==========================================

func remove_life() -> int:

        lives -= 1

        if lives < 0:

                lives = 0

        return lives


# ==========================================
# HAS LIVES
# ==========================================

func has_lives() -> bool:

        return lives > 0


# ==========================================
# SET WIN
# ==========================================

func set_won():

        game_won = true

        game_over = false

        busy = false


# ==========================================
# SET GAME OVER
# ==========================================

func set_game_over():

        game_over = true

        game_won = false

        busy = false


# ==========================================
# SET BUSY
# ==========================================

func set_busy(
        value: bool
):

        busy = value


# ==========================================
# SELECT PASSENGER
# ==========================================

func select_passenger(
        index: int
):

        selected_passenger = index


# ==========================================
# CLEAR SELECTION
# ==========================================

func clear_selection():

        selected_passenger = -1


# ==========================================
# GET SCORE
# ==========================================

func get_score() -> int:

        return score


# ==========================================
# GET LIVES
# ==========================================

func get_lives() -> int:

        return lives


# ==========================================
# GET SELECTED PASSENGER
# ==========================================

func get_selected_passenger() -> int:

        return selected_passenger


# ==========================================
# IS WON
# ==========================================

func is_won() -> bool:

        return game_won


# ==========================================
# IS GAME OVER
# ==========================================

func is_game_over() -> bool:

        return game_over


# ==========================================
# IS BUSY
# ==========================================

func is_busy() -> bool:

        return busy