extends Node2D

var _ammo
var _max_ammo = 70

func use( target ):
	if target == null or !target.is_in_group("ranged_weapon"):
		return
	else:
		_ammo = target.reload(_ammo)
	if _ammo <= 0:
		get_parent().remove_item(self)
		queue_free()


func get_name():
	return "Ammunition"
	
func get_description():
	return "All ranged weapons fitting ammunition. Holding "+str(get_count())+"/70"

func get_count():
	return _ammo

func _ready():
	_ammo = floor(rand_range(2, _max_ammo))
	add_to_group("ammunition")

