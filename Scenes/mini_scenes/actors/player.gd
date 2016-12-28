extends Node2D

var _next_action

var _energy = 1

var sight_radius = 10

var cell_pos setget cell_pos_set
func cell_pos_set( value ):
	cell_pos = value
	set_pos( value * 16 )

func _ready():
	cell_pos = get_pos() / 16
	get_node("/root/homebase_scene")._on_add_actor(self)

func can_act():
	if _energy >= 0:
		return true
	else:
		return false

func get_action():
	if _next_action != null:
		var action = _next_action
		_next_action = null
		set_process_input( false )
		return action
	else:
		set_process_input( true )

func _input(event):
	if event.is_action_pressed("move_w"):
		#set_pos( get_pos() + directions.W * 16 )
		_next_action = Vector2( directions.W )
	if event.is_action_pressed("move_n"):
		#set_pos( get_pos() + directions.N * 16 )
		_next_action = Vector2( directions.N )
	if event.is_action_pressed("move_e"):
		#set_pos( get_pos() + directions.E * 16 )
		_next_action = Vector2( directions.E )
	if event.is_action_pressed("move_s"):
		#set_pos( get_pos() + directions.S * 16 )
		_next_action = Vector2( directions.S )
