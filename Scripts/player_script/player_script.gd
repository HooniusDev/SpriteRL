extends Node2D

var armour setget armour_set
func armour_set( item ):
	if !item.is_in_group("armour"):
		print("Not an armour!")
		return
	if armour != null or item == null:
		print("You remove your current armour..")
		armour = null
	armour = item

var gloves setget gloves_set
func gloves_set( item ):
	if !item.is_in_group("gloves"):
		print("Not a pair of gloves!")
		return
	if gloves != null or item == null:
		print("You remove your current gloves..")
		gloves = null
	gloves = item

var _armour_class setget ,armour_class_get
func armour_class_get():
	var total_ac
	total_ac += armour.ac + gloves.ac
	return ac

#pickup a item that is clicked on map
func _pickup_item( item ):
	#if item in same cell as player.. pick it up
	pass
	
func move( direction ):
	#if unblocked -> move -> reduce ap
	#else if blocked by hostile -> attack -> reduce ap
	#else if blocked by wall -> bump -> wait for input 
	pass

var _health

func take_damage( amount):
	var damage_reduce
	var total_damage_taken = amount - armour_class_get()
	if total_damage_taken < 0:
		total_damage_taken = 0
	_health -= total_damage_taken
	
var _strenght
func deal_damage():
	#sum up all factoring things
	var total_damage = _strenght
	return total_damage
