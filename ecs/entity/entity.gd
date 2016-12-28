extends Node2D

var _components = {}

const CELL_POSITION = "cell_position"
const SPRITE_COMPONENT = "sprite_component"
const PLAYER_CONTROL_COMPONENT = "player_control"

func _input(event):
	var pcc = get_component( PLAYER_CONTROL_COMPONENT )
	if pcc != null:
		var action = pcc.work_input(event)
		if action != null:
			var cpc = get_component(CELL_POSITION)
			cpc.set_cell(get_cell() + action)
	pass

func _ready():
	print("Entity " + get_name() + " created.")
	pass
	
func get_cell():
	if _components.has( CELL_POSITION ):
		return _components[CELL_POSITION].get_cell()

func get_component( component_type ):
	if _components.has(component_type):
		print("get_component( " + str(component_type))
		return _components[component_type]
	else:
		return null

func has_component( component_type ):
	if _components.has(component_type):
		return true
	else:
		return false
		
func add_component( component ):
	var type = component.type
	print ( "adding " + str(type) )
	if !_components.has(type):
		_components[type] = component
		component._on_added( self )
		
		
		