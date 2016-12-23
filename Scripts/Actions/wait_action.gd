#wait_action
extends Node2D

var type = "wait_action"
var owner
var msg = "Waiting..."

func _init( owner ):
	self.owner = owner

func perform():
	return true