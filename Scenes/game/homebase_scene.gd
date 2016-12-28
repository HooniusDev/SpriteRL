extends Node

const HOSTILE_FACTION = "hostile_faction"
const FRIENDLY_FACTION = "friendly_faction"

var _cur_actor_index = 0
var _cur_actor

var friendly_actors = []
var hostile_actors = []
var all_actors = []

var dynamic_objects = []

var first_start = true

func _process(delta):
	if dynamic_objects.size() > 0:
		for obj in dynamic_objects:
			obj.perform()
		return
	
	if all_actors.size() > 0:
		_cur_actor = all_actors[_cur_actor_index]
	else:
		print( "NO ACTORS IN SCENE" )
	if !_cur_actor.can_act():
		next_actor()
	
	var action = _cur_actor.get_action()
	if action == null:
		return
	else:
		if typeof(action) == TYPE_VECTOR2:
			get_node("map_manager").move_actor(_cur_actor, _cur_actor.cell_pos + action )

func next_actor( ):
	_cur_actor = (_cur_actor + 1) % all_actors.size();
	if _cur_actor.is_in_group("player"):
		get_node("map_manager").update_fov( _cur_actor.cell_pos, _cur_actor.sight_radius )

func _on_add_dynamic_object( object ):
	dynamic_objects.append( object )
	
func _on_remove_dynamic_object( object ):
	dynamic_objects.remove( object )
	
func _on_add_actor( actor ):
	print("Adding actor")
	if actor.is_in_group(HOSTILE_FACTION):
		friendly_actors.append( actor )
	elif actor.is_in_group(FRIENDLY_FACTION):
		hostile_actors.append( actor )
	else:
		print( "NO FACTION GROUP FOUND!!" )
	all_actors.append( actor )
	
func _on_remove_actor( actor):
	if actor.is_in_group(HOSTILE_FACTION):
		hostile_actors.remove( actor )
	if actor.is_in_group(FRIENDLY_FACTION):
		friendly_actors.remove( actor )
	all_actors.remove( actor )

func _ready():
	set_process( true )
	#if first_start:
	#	get_node("map_manager").spawn
	pass


