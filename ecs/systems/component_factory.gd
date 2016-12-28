extends Node
#component_factory.gd

const CELL_POSITION= preload("res://ecs/components/cell_position.gd")
const SPRITE_COMPONENT = preload("res://ecs/components/sprite_component.gd")
const PLAYER_CONTROL_COMPONENT = preload("res://ecs/components/player_control_component.gd")

func add_player_control(entity):
	var pcc = PLAYER_CONTROL_COMPONENT.new()
	entity.add_component(pcc)
	return pcc
	
func add_cell_position(entity, cell):
	var cpc = CELL_POSITION.new()
	cpc.set_cell(cell)
	entity.add_component(cpc)
	
	
func add_sprite_component(entity, texture, frame):
	var sprite = SPRITE_COMPONENT.new()
	sprite.set_texture( texture )
	# hard coded 16*16 sprites
	sprite.set_hframes( texture.get_size().x/16 )
	sprite.set_vframes( texture.get_size().y/16 )
	sprite.set_frame( frame )
	#entity.add_child(sprite)
	entity.add_component(sprite)
	return sprite
