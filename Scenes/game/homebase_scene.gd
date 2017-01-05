extends Node

const HOSTILE_FACTION = "hostile_faction"
const FRIENDLY_FACTION = "friendly_faction"

var _cur_actor_index = 0
var _cur_actor
var tick = 0

var friendly_actors = []
var hostile_actors = []
var all_actors = []

var dynamic_objects = []

var first_start = true
var player_alive = true

func _input(event):
	if event.is_pressed():
		get_tree().reload_current_scene()

func _process(delta):
	if !player_alive:
		get_node("gui/game_over").show()
		set_process_input(true)
		return
	if dynamic_objects.size() > 0:
		for obj in dynamic_objects:
			obj.perform()
		return
	
	if all_actors.size() > 0:
		if _cur_actor_index < all_actors.size():
			_cur_actor = all_actors[_cur_actor_index]
	else:
		print( "NO ACTORS IN SCENE" )

	while !_cur_actor.can_act():
		next_actor()
		if _cur_actor == null:
			next_actor()
	
	var action = _cur_actor.get_action()
	if action == null:
		return
	else:
		if typeof(action) == TYPE_VECTOR2:
			#print ( "moving: " + _cur_actor.get_name() + ", energy: " + str( _cur_actor.energy) )
			get_node("map_manager").move_actor(_cur_actor, _cur_actor.cell_pos + action )
			_cur_actor.energy = _cur_actor.energy - 5
			return
		if action.has_method("damage") and action.faction != _cur_actor.faction:
			print(_cur_actor.get_name() +  " ATTACKS!")
			action.damage( _cur_actor.melee_damage )
			_cur_actor.energy = _cur_actor.energy - 5

func next_actor( ):
	_cur_actor_index = (_cur_actor_index + 1) % all_actors.size();
	#if !all_actors.has(_cur_actor_index):
	#	next_actor()
	_cur_actor = all_actors[_cur_actor_index]
	if _cur_actor_index == 0:
		#print("tick: " + str(tick))
		tick += 1
		for actor in all_actors:
			actor.energy += 1 * actor.energy_regen_rate
	if _cur_actor.is_in_group("player"):
		get_node("map_manager").update_fov( _cur_actor.cell_pos, _cur_actor.sight_radius )

func _on_add_dynamic_object( object ):
	dynamic_objects.append( object )
	
func _on_remove_dynamic_object( object ):
	dynamic_objects.remove( object )
	
func _on_add_actor( actor ):
	print("Adding actor")
	if actor.is_in_group("player"):
		get_node("map_manager").player = actor
	if actor.is_in_group(FRIENDLY_FACTION):
		friendly_actors.append( actor )
	elif actor.is_in_group(HOSTILE_FACTION):
		hostile_actors.append( actor )
	else:
		print( "NO FACTION GROUP FOUND!!" )
	all_actors.append( actor )
	
func _on_remove_actor( actor):
	get_node("map_manager")._tilemap.remove_actor(actor)
	if actor.is_in_group("player"):
		print("ITS GAME OVER MAN!")
		player_alive = false
	if actor.is_in_group(HOSTILE_FACTION):
		hostile_actors.erase( actor )
	if actor.is_in_group(FRIENDLY_FACTION):
		friendly_actors.erase( actor )
	all_actors.erase( actor )

func _ready():
	globals.homebase_scene = self
	set_process( true )
	
	globals.game_state._process()
	#if first_start:
	#	get_node("map_manager").spawn
	pass


