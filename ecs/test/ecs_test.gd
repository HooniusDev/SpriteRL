extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var test_sprite = preload("res://Sprites/GameSpriteSheet_04.png")

func _ready():
	var test1 = entity_factory.create_entity()
	test1.set_name("test1")
	add_child(test1)
	
	component_factory.add_cell_position(test1, Vector2(3,2))
	component_factory.add_sprite_component( test1, test_sprite, 1 )
	component_factory.add_player_control(test1)
	
	pass
