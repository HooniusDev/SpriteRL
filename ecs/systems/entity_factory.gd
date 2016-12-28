extends Node

const ENTITY = preload("res://ecs/entity/entity.gd")

func create_entity():
	var entity = ENTITY.new()
	return entity

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
