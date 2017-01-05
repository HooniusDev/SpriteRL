#state.gd

var _state
var _game_scene

func change_state( new_state ):
	_state._end()
	_state = new_state
	_state._start()
	pass

func _init( game_scene ):
	_game_scene = game_scene
	pass
	
func _start():
	pass
	
func _process():
	return "state.process()"
	
func _end():
	pass
