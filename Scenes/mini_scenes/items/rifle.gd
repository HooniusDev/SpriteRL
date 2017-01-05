extends Node2D

var _damage = 5

var _accuracy = 40
var _range = 30

var _clip_size = 35# max ammo
var _ammo

func reload(amount):
	_ammo += amount
	if _ammo > _clip_size:
		amount = _ammo - _clip_size
		_ammo = _clip_size
		return amount
	else:
		return 0

func _ready():
	_ammo = floor(rand_range(2, _clip_size))
	add_to_group("ranged_weapon")
	
func get_count():
	return _ammo

func get_name():
	return "Rifle"
	
func get_description():
	return "Highpowered military assault rifle. Ammo "+str(_ammo)+"/35 (5.56mm)"

func shoot(  ):
	if _ammo > 0:
		_ammo -= 1
		print("Rifle shot!")
		return true
	else:
		print("out of ammo")
