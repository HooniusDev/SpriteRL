extends Node2D

var _damage = 2

var _accuracy = 10
var _range = 10

var _clip_size = 8# max ammo
var _ammo

func wield():
	pass
	
func reload(amount):
	_ammo += amount
	if _ammo > _clip_size:
		amount = _ammo - _clip_size
		_ammo = _clip_size
		return amount
	else:
		return 0

func get_count():
	return _ammo

func _ready():
	_ammo = floor(rand_range(2, _clip_size))
	add_to_group("ranged_weapon")

func get_name():
	return "Pistol"
	
func get_description():
	return "Semiautomatic pistol. Ammo "+str(_ammo)+"/8 (9mm)"

func shoot(  ):
	if _ammo > 0:
		_ammo -= 1
		print("pistol shot!")
		return true
	else:
		print("out of ammo")
