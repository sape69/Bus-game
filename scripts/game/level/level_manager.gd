extends Node

# ==========================================
# BUS MATCH OUT
# LEVEL MANAGER
# ==========================================
# Tason vaihtamisen ja nykyisen tason hallinta
# ==========================================


# ==========================================
# DEFAULT LEVEL
# ==========================================

const DEFAULT_LEVEL := 1


# ==========================================
# CURRENT LEVEL
# ==========================================

var current_level := DEFAULT_LEVEL


# ==========================================
# RESET
# ==========================================

func reset():

        current_level = DEFAULT_LEVEL


# ==========================================
# SET LEVEL
# ==========================================

func set_level(
        level: int
):

        if level < 1:
                current_level = DEFAULT_LEVEL
                return

        current_level = level


# ==========================================
# NEXT LEVEL
# ==========================================

func next_level() -> int:

        current_level += 1

        return current_level


# ==========================================
# GET CURRENT LEVEL
# ==========================================

func get_current_level() -> int:

        return current_level


# ==========================================
# GET LEVEL TEXT
# ==========================================

func get_level_text() -> String:

        return "Taso %d" % current_level