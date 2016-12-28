extends Node2D

func get_action():
	return true
	
func can_act():
	return true

func _ready():
	get_tree().get_root().get_node("homebase_scene")._on_add_actor(self)
	pass
