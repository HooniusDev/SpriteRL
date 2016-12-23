#move_action
extends Node2D

var type = "move_action"
var owner
var direction
var target_cell
var msg

const SUCCESS_TEXT = ", Move succeeded."
const FAILURE_TEXT = ", Cant move there."

func _init( owner, direction ):
	self.owner = owner
	self.direction = direction 
	self.target_cell = owner.cell_pos + direction

func perform():
	if _can_move( ):
		msg = SUCCESS_TEXT
		owner.cell_pos = target_cell
		return true
	else:
		msg = FAILURE_TEXT
		return false
	
func _can_move( ):
	#var target_cell = owner.tile_pos + direction
	#if !globals.world.is_passable( target_cell ):
	#	print("move target cell:" + str(target_cell))
	#	return false
	return true
	
	