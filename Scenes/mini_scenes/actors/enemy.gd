extends Node2D

var _next_action

var _energy = 1

var sight_radius = 5

var cell_pos setget cell_pos_set
func cell_pos_set( value ):
	cell_pos = value
	set_pos( value * 16 )

func show():
	get_node("sprite").show()
	
func hide():
	get_node("sprite").hide()

func _ready():
	cell_pos = get_pos() / 16
	get_node("/root/homebase_scene")._on_add_actor(self)

func can_act():
	if _energy >= 0:
		return true
	else:
		return false

func get_action():
	return action_factory.new_move( self, directions.get_random() )
