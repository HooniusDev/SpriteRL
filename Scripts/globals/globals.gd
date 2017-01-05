extends Node

var game_state

var player
var homebase_scene
var map_manager
var tilemap_controller
var gui_controller

func _ready():
	game_state = load("res://Scripts/state/player_turn.gd").new(self)

func get_player_cell():
	return player.cell_pos

