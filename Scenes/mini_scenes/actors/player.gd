extends Node2D

var _next_action

var energy = 1
var energy_regen_rate = 1

var sight_radius = 10

var move_marker

var health = 5
var melee_damage = 1
var faction = "allied"

var cell_pos setget cell_pos_set
func cell_pos_set( value ):
	cell_pos = value
	set_pos( value * 16 )
	

func damage(amount):
	health -= amount
	if health <= 0:
		die()
		
func die():
	get_node("/root/homebase_scene")._on_remove_actor(self)
	queue_free()

func _ready():
	cell_pos = get_pos() / 16
	get_node("/root/homebase_scene")._on_add_actor(self)
	move_marker = get_node("move_marker")

func can_act():
	if energy >= 0:
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
		#get_node("move_marker").show()
		

func _input(event):
	var mouse_pos = utils.map_manager._tilemap.world_to_map(get_global_mouse_pos())
	var action = "move"
	if cell_pos != mouse_pos:
		var target_cell = utils.get_move_dir( cell_pos, mouse_pos)
		var target = utils.map_manager.get_blocker(target_cell)
		#target is false when 
		if typeof(target) == TYPE_VECTOR2: # retruned vector2 so it is passable
			move_marker.set_frame(3)
			move_marker.show()
		if target == null: # returned null so its a wall etc.
			move_marker.hide()
		if typeof(target) == TYPE_OBJECT:
			move_marker.set_frame(13)
			move_marker.show()
			action = "attack"
				#move_marker.set_pos( target.cell_pos )

		#make a move
		target_cell = target_cell - cell_pos
		if target_cell != Vector2(0,0):
			move_marker.set_offset( Vector2( target_cell.x * 16, target_cell.y*16) )
			if event.type == InputEvent.MOUSE_BUTTON:
				if event.button_index == BUTTON_LEFT and event.pressed:
					if action == "move":
						_next_action = Vector2(target_cell)
						move_marker.hide()
						return
					elif action == "attack":
						_next_action = target
						move_marker.hide()
						return
	else:
		move_marker.hide()
	
	if event.is_action_pressed("move_w"):
		#set_pos( get_pos() + directions.W * 16 )
		_next_action = Vector2( directions.W )
		move_marker.hide()
	if event.is_action_pressed("move_n"):
		#set_pos( get_pos() + directions.N * 16 )
		_next_action = Vector2( directions.N )
		move_marker.hide()
	if event.is_action_pressed("move_e"):
		#set_pos( get_pos() + directions.E * 16 )
		_next_action = Vector2( directions.E )
		move_marker.hide()
	if event.is_action_pressed("move_s"):
		#set_pos( get_pos() + directions.S * 16 )
		_next_action = Vector2( directions.S )
		move_marker.hide()