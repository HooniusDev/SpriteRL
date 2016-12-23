extends Sprite

func _ready():
	set_process_input(true)
	pass

func _input(event):
	#if is_player:
	#if event.is_action_released("end_turn"):
	#	_next_action = wait_action.new( self )
	if event.is_action_pressed("move_w"):
		get_parent().get_parent().get_parent().on_player_move( self, get_pos() + directions.W * 16  )
		#_next_action = move_action.new( self, directions.W )
	if event.is_action_pressed("move_n"):
		get_parent().get_parent().get_parent().on_player_move( self, get_pos() + directions.N * 16 )
		#_next_action = move_action.new( self, directions.N )
	if event.is_action_pressed("move_e"):
		get_parent().get_parent().get_parent().on_player_move( self,get_pos() + directions.E * 16 )
		#_next_action = move_action.new( self, directions.E )
	if event.is_action_pressed("move_s"):
		get_parent().get_parent().get_parent().on_player_move( self, get_pos() + directions.S * 16 )
		#_next_action = move_action.new( self, directions.S )
