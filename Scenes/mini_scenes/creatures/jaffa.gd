extends Node2D

const TILESIZE = 16
var move_action = preload("res://Scripts/Actions/move_action.gd")

var cell_pos setget cell_pos_set
func cell_pos_set( value ):
	cell_pos = value
	set_pos( value * TILESIZE )

func get_action():
		return move_action.new( self, directions.W )

func _on_turn_end():
	
	pass
	
func _on_turn_start():
	
	pass

func _ready():
	cell_pos = Vector2(0,0)
	# Called every time the node is added to the scene.
	# Initialization here
	pass
