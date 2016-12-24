extends Node2D

var mobs = []
var _current_mob = -1

var wait_timer = 0.2
var anim_speed = 0.2

func _process(delta):
	
	wait_timer -= delta
	if wait_timer > 0:
		return
	else:
		wait_timer = anim_speed
	if get_node("map_controller/tilemap").get_animating_objects().size() > 0:
		for obj in get_node("map_controller/tilemap").animating_objects:
			obj.perform()
		return
	var action = mobs[_current_mob].get_action()
	
	if action == null:
		return
	else:
		if action.type == "move_action":
			if get_node("map_controller").try_move_action(action):
				next_mob()
		#_log_action(action)

func next_mob( ):
	if _current_mob == -1:
		_current_mob = 0
	else:
		_current_mob = (_current_mob + 1) % mobs.size();


func _ready():
	_current_mob = 0
	mobs = get_node("map_controller/tilemap/creatures").get_children()
	set_process( true )
	pass
