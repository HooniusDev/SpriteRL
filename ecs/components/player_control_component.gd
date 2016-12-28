extends Node

var type = "player_control"
var owner

func _on_added( owner ):
	print("player_control_component added")
	self.owner = owner
	owner.set_process_input(true)
	pass
	
func work_input( event ):
	var _next_action
	if event.is_action_pressed("move_w"):
		_next_action = Vector2( directions.W )
	if event.is_action_pressed("move_n"):
		_next_action = Vector2( directions.N )
	if event.is_action_pressed("move_e"):
		_next_action = Vector2( directions.E )
	if event.is_action_pressed("move_s"):
		_next_action = Vector2( directions.S )
	return _next_action
