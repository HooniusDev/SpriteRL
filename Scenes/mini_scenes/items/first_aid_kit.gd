extends Node2D

var _heal_points = 5

func get_name():
	return "First aid kit"
	
func get_description():
	return "First aid kit to tend your wounds. Heals 5 points"
	
func use( actor ):
	if actor.heal(_heal_points):
		get_parent().remove_item(self)
		queue_free()
	else:
		print("No wounds to tend to.")
	
func _ready():
	add_to_group("usable_items")

