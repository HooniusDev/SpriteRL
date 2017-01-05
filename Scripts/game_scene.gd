extends Node2D

var game_state

var mobs = []
var _current_mob = -1

var turn_counter = 0
var tick = 0

func _process(delta):
	if get_node("map_controller/tilemap").get_animating_objects().size() > 0:
		for obj in get_node("map_controller/tilemap").animating_objects:
			obj.perform()
		return
	
	
	mobs = get_node("map_controller/tilemap/creatures").get_children()
	var _cur = mobs[_current_mob]
	
	if ( _cur.energy < 0 ):
		_cur.energy += 1*_cur.energy_regen
		#print("Energy: " + str( mobs[_current_mob].energy ) + " on " + mobs[_current_mob].get_name()) 
		next_mob()
		return
		
	var action = mobs[_current_mob].get_action()
	
	if action == null:
		return
	else:
		if action.type == "move_action":
			if get_node("map_controller").try_move_action(action) == true:
				next_mob()
		if action.type == "open_door":
			if get_node("map_controller").try_move_action(action) == true:
				next_mob()
				#print("Energy: " + str( mobs[_current_mob].energy ) + " on " + mobs[_current_mob].get_name()) 

				

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
