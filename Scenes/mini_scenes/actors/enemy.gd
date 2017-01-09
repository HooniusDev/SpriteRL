extends Node2D

var _next_action

var energy = 1
var energy_regen_rate = .8

var sight_radius = 5
var in_player_sight = false

var health = 10
var health_max = 10
var melee_damage = 1
var faction = "hostile"

var is_dead = false

func take_damage(amount):
	health -= amount
	get_node("healthbar")._on_health_changed(health, health_max)
	utils.on_damage( get_pos(), amount )
	if health <= 0:
		die()
		
func die():
	#get_node("/root/homebase_scene")._on_remove_actor(self)
	print("Enemy yells: ARRGGHH I DIES!" )
	get_node("sprite").set_frame(17)
	is_dead = true
	pass

var cell_pos setget cell_pos_set
func cell_pos_set( value ):
	cell_pos = value
	if in_player_sight:
		set_pos( value * 16 )

func set_in_player_sight( seen ):
	in_player_sight = seen

func show():
	in_player_sight = true
	get_node("sprite").show()
	get_node("healthbar")._on_health_changed(health, health_max)
	
func hide():
	in_player_sight = false
	get_node("sprite").hide()
	get_node("healthbar").hide()

func _ready():
	hide()
	
	cell_pos = get_pos() / 16
	get_node("/root/homebase_scene")._on_add_actor(self)

func can_act():
	if energy >= 0:
		return true
	else:
		return false

func get_action():
	var los = utils.check_los( cell_pos, 5 )
	if typeof(los) == TYPE_VECTOR2:
		#print( get_name() + "sees player!")
		#var target_cell = utils.get_move_dir( cell_pos, mouse_pos)
		var target = utils.map_manager.get_blocker(los)
		if typeof(target) == TYPE_VECTOR2:
			return los - cell_pos
		if typeof(target) == TYPE_OBJECT:
			return target
	return directions.get_random()
	#return action_factory.new_move( self, directions.get_random() )
