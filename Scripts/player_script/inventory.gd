extends Node
#inventory.gd

var _items = []

var _weapon
var _armour
var _helmet

func get_inventory():
	return _items
	
func get_item(index):
	if index < _items.size():
		return _items[index]
	else:
		return null

func add_item(item):
	_items.append(item)
	add_child(item)
	item.hide()

func remove_item(item):
	if typeof(item) == TYPE_OBJECT:
		_items.erase(item)
		remove_child(item)
		return
	_items.remove(item)
	if _weapon == item:
		_weapon = null
	remove_child(item)

func wear(index):
	var item = _items[index]
	if item.is_in_group("armour"):
		if _armour != null:
			#print("weapon was NOT null")
			#_items.erase(index)
			_items[index] = _armour
			_armour = item
		else:
			#print("weapon was null")
			_items.erase(item)
			_armour = item
		return
	if item.is_in_group("helmet"):
		if _helmet != null:
			#print("weapon was NOT null")
			#_items.erase(index)
			_items[index] = _helmet
			_helmet = item
		else:
			#print("weapon was null")
			_items.erase(item)
			_helmet = item
		return
	print("Not AN ARMOUR or HELMET")


func ready_weapon(index):
	var item = _items[index]
	if !item.is_in_group("ranged_weapon"):
		print("Not A WEAPON")
		return
	if _weapon != null:
		#print("weapon was NOT null")
		#_items.erase(index)
		_items[index] = _weapon
		_weapon = item
	else:
		#print("weapon was null")
		_items.erase(item)
		_weapon = item

func wields_ranged():
	if _weapon != null:
		if _weapon.is_in_group("ranged_weapon") and _weapon._ammo > 0:
			return true
	else:
		return false
	
