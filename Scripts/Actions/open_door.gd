#base_action
extends Node2D

var type = "door_open_action"
var owner
var target_cell
var msg
var energy_cost = 5

func init( owner, cell ):
	self.owner = owner
	self.target_cell = cell
	return self

func perform():
	owner.energy = owner.energy - energy_cost
	return true #return true to end turn

func cancel():
	_clear()
	
func _clear():
	owner = null
	target_cell = null