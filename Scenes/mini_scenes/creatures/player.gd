extends Sprite

const TILESIZE = 16

var _next_action

var energy = 0
var energy_regen = 1

var cell_pos setget cell_pos_set
func cell_pos_set( value ):
	cell_pos = value
	set_pos( value * TILESIZE )
	

func get_action():
	if _next_action != null:
		var action = _next_action
		_next_action = null
		set_process_input( false )
		return action
	else:
		set_process_input( true )

func _ready():
	cell_pos = Vector2(0,0)
	#set_process_input(true)
	pass
	
func blocks_cell():
	return self

func _input(event):
	#if is_player:
	#if event.is_action_released("end_turn"):
	#	_next_action = wait_action.new( self )
	if event.is_action_pressed("move_w"):
		_next_action = action_factory.new_move( self, directions.W )
	if event.is_action_pressed("move_n"):
		_next_action = action_factory.new_move( self, directions.N )
	if event.is_action_pressed("move_e"):
		_next_action = action_factory.new_move( self, directions.E )
	if event.is_action_pressed("move_s"):
		_next_action = action_factory.new_move( self, directions.S )
