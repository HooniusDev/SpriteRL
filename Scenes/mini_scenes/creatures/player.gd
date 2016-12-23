extends Sprite

const TILESIZE = 16

var move_action = preload("res://Scripts/Actions/move_action.gd")
var wait_action = preload("res://Scripts/Actions/wait_action.gd")
var shoot_action = preload("res://Scripts/Actions/shoot_action.gd")
var target_action = preload("res://Scripts/Actions/target_action.gd")


var _next_action

var cell_pos setget cell_pos_set
func cell_pos_set( value ):
	cell_pos = value
	set_pos( value * TILESIZE )
	
func _on_turn_end():
	
	pass
	
func _on_turn_start():
	
	pass

func get_action():
	if _next_action != null:
		var action = _next_action
		_next_action = null
		print ( "palyer acts")
		return action

func _ready():
	cell_pos = Vector2(0,0)
	set_process_input(true)
	pass

func _input(event):
	#if is_player:
	#if event.is_action_released("end_turn"):
	#	_next_action = wait_action.new( self )
	if event.is_action_pressed("move_w"):
		#get_parent().get_parent().get_parent().on_player_move( self, get_pos() + directions.W * 16  )
		_next_action = move_action.new( self, directions.W )
	if event.is_action_pressed("move_n"):
		#get_parent().get_parent().get_parent().on_player_move( self, get_pos() + directions.N * 16 )
		_next_action = move_action.new( self, directions.N )
	if event.is_action_pressed("move_e"):
		#get_parent().get_parent().get_parent().on_player_move( self,get_pos() + directions.E * 16 )
		_next_action = move_action.new( self, directions.E )
	if event.is_action_pressed("move_s"):
		#get_parent().get_parent().get_parent().on_player_move( self, get_pos() + directions.S * 16 )
		_next_action = move_action.new( self, directions.S )
