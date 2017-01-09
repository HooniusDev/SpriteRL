extends Node2D

var _armour_class
var _ac_max = 3

func get_name():
	return "Helmet"
	
func get_description():
	return "Basic combat Helmet. AC "+str(_armour_class)

func _ready():
	_armour_class = 3
	add_to_group("helmet")
