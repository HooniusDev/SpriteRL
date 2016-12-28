#move_action
extends Node2D

var type = "move_action"
var owner
var direction
var target_cell
var msg

const SUCCESS_TEXT = ", Move succeeded."
const FAILURE_TEXT = ", Cant move there."

func _clear():
	owner = null
	direction = null
	target_cell = null

func init( owner, direction ):
	self.owner = owner
	self.direction = direction 
	self.target_cell = owner.cell_pos + direction
	return self

func perform():
	owner.cell_pos = target_cell
	owner.energy = owner.energy -10
	_clear()
	
func cancel():
	_clear()
