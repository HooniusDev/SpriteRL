extends Node2D

func get_name():
	return "Cpl. Donk"
	
func health_to_string():
	return str(health) + "/" + str(health_max)

onready var inventory = preload("res://Scenes/mini_scenes/actors/inventory.tscn").instance()
#var inventory
var inventory_shown = false

var targetting_mode = false

var _next_action

var energy = 1
var energy_regen_rate = 1

var sight_radius = 10

var move_marker

var health = 5
var health_max = 10

var melee_damage = 1

var is_dead = false

func get_ac():
	var ac = 0
	if inventory._armour != null:
		ac += inventory._armour._armour_class
	if inventory._helmet != null:
		ac += inventory._helmet._armour_class
	return ac

var faction = "allied"

var cell_pos setget cell_pos_set
func cell_pos_set( value ):
	cell_pos = value
	set_pos( value * 16 )
	
func pickup_item( item ):
	print( "You pickup: " + item.get_name())
	globals.tilemap_controller.remove_item(item)
	inventory.add_item(item)
	
func drop_item(item):
	item = inventory._items[item]
	print("you drop: " + item.get_name())
	inventory.remove_item(item)
	item.set_pos(get_pos())
	globals.tilemap_controller.add_item(item)

func parent_item( item ):
	inventory.add_item( item )

func take_damage(amount):
	health -= amount
	utils.on_damage( get_pos(), amount )
	if health <= 0:
		die()

func heal(amount):
	if health < health_max:
		health += amount
		if health > health_max:
			amount = health - health_max
			health = health_max
		utils.on_heal( get_pos(), amount )
		print("You feel much better")
		
		return true
	else:
		return false
		
func die():
	get_node("/root/homebase_scene")._on_remove_actor(self)
	queue_free()

func _ready():
	globals.player = self
	#inventory = inventory_scene.instance()
	add_child(inventory)
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
		set_process_unhandled_input(true)
	
func toggle_targetting_mode():
	if targetting_mode == true:
		targetting_mode = false
	else:
		targetting_mode = true
		
func toggle_inventory():
	if inventory_shown == false:
		inventory_shown = true
		globals.gui_controller.show_inventory()
	else:
		inventory_shown = false
		globals.gui_controller.hide_inventory()
		
func handle_mouse():
	# ADD MOUSE CONTROL STUFF!!!
	# CHAANGE CURSOR, SHOW TOOLTIP 
	pass

func _unhandled_input(event):
	if inventory_shown == false:
		var mouse_pos = utils.map_manager._tilemap.world_to_map(get_global_mouse_pos())
		var action = "move"
		if cell_pos != mouse_pos:
			if inventory.wields_ranged():
				var blocker = globals.map_manager.get_blocker(mouse_pos)
				#if typeof(blocker) == TYPE_OBJECT and blocker.has_method("get_name"):
					#print(blocker.get_name())
				if typeof(blocker) == TYPE_OBJECT and blocker.is_in_group("hostile_faction"):
					var pos = Vector2( (mouse_pos.x-cell_pos.x) * 16, (mouse_pos.y-cell_pos.y)*16)
					move_marker.show_crosshair( pos)
					if event.type == InputEvent.MOUSE_BUTTON:
						if event.button_index == BUTTON_LEFT and event.pressed:
							if inventory._weapon.shoot():
								utils.resolve_shot( self, blocker )
							return
					else:
						return
			var target_cell = utils.get_move_dir( cell_pos, mouse_pos)
			var target = utils.map_manager.get_blocker(target_cell)
			#target is false when 
			if typeof(target) == TYPE_VECTOR2: # retruned vector2 so it is passable
				#move_marker.set_frame(3)
				var dir = target - cell_pos
				var dirs = directions.DirArray
				for i in range(dirs.size()):
					if dir == dirs[i]:
						#move_marker.set_texture( cursors[i] )
						move_marker.show_arrow( i )
				move_marker.show()
			if target == null: # returned null so its a wall etc.
				move_marker.hide()
			if typeof(target) == TYPE_OBJECT:
				#move_marker.set_frame(13)
				move_marker.show()
				action = "attack"
				#GET TO HIT MODIFIER
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
		
	if event.is_action_pressed("toggle_targetting"):
		toggle_targetting_mode()
	if event.is_action_pressed("toggle_inventory"):
		toggle_inventory()
	
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