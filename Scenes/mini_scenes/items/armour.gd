extends Node2D

var _armour_class
var _ac_max = 6

func get_name():
	return "Armour"
	
func get_description():
	return "Basic combat Armour. AC "+str(_armour_class)

func _ready():
	_armour_class = floor(rand_range(2, _ac_max))
	add_to_group("armour")