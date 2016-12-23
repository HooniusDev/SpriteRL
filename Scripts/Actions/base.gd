#base_action
extends Node2D

var owner
var msg

func _init( owner ):
	self.owner = owner

func perform():
	return true #return true to end turn
