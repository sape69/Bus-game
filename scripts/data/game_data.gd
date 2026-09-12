class_name GameData
extends RefCounted

# ==========================================
# BUS MATCH OUT
# PELIN YLEISET ASETUKSET
# ==========================================

# ------------------------------------------
# PELIALUE
# ------------------------------------------

const COLS := 5
const ROWS := 5

const CELL_SIZE := 65.0

const GRID_X := 20.0
const GRID_Y := 125.0


# ------------------------------------------
# BUSSIT
# ------------------------------------------

const BUS_Y := 665.0
const BUS_WIDTH := 100.0
const BUS_HEIGHT := 70.0
const BUS_GAP := 15.0

const BUS_CAPACITY := 4
const BUS_COUNT := 4


# ------------------------------------------
# MATKUSTAJAT
# ------------------------------------------

const PASSENGER_RADIUS := 22.0

const PASSENGER_COUNT := 25


# ------------------------------------------
# PELI
# ------------------------------------------

const STARTING_LIVES := 3

const POINTS_PER_PASSENGER := 10

const MOVE_TIME := 0.35


# ------------------------------------------
# RUUDUN KOKO
# ------------------------------------------

const SCREEN_WIDTH := 480.0
const SCREEN_HEIGHT := 850.0


# ------------------------------------------
# VÄRIT
# ------------------------------------------

static var COLORS := [
	Color("#ef5350"), # Punainen
	Color("#42a5f5"), # Sininen
	Color("#66bb6a"), # Vihreä
	Color("#ffca28")  # Keltainen
]


# ------------------------------------------
# TAUSTAN VÄRIT
# ------------------------------------------

const DARK_BACKGROUND := Color("#101820")
const GRID_COLOR := Color("#263238")
const GRID_BORDER := Color("#455a64")

const HEADER_COLOR := Color("#162329")

const WHITE := Color("#ffffff")
const DARK := Color("#111111")