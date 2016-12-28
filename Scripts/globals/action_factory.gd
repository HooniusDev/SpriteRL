extends Node

var move_action = preload("res://Scripts/Actions/move_action.gd")
var wait_action = preload("res://Scripts/Actions/wait_action.gd")
var shoot_action = preload("res://Scripts/Actions/shoot_action.gd")
var target_action = preload("res://Scripts/Actions/target_action.gd")
var open_door_action = preload("res://Scripts/Actions/open_door.gd")


const MOVE_ACTION = "move_action"
const WAIT_ACTION = "wait_action"
const SHOOT_ACTION = "shoot_action"
const TARGET_ACTION = "target_action"
const MELEE_ACTION = "melee_action"
const DOOR_OPEN_ACTION = "door_open_action"

var move_action_instance

func new_move( owner, direction ):
	return move_action_instance.init( owner, direction )

func _ready():
	move_action_instance = move_action.new()
	pass
