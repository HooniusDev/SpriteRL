#shoot_action
extends Node2D

var projectile = preload("res://Scenes/mini_scenes/animating_objects/projectile.tscn")

var type = "shoot_action"
var owner
var target
var msg = ", Shoots"
 

func _init( owner, target ):
	self.owner = owner
	self.target = target
	
func perform():
	owner.weapon.fire(owner, target)
	return true
	# create "projectile mob" that moves per cell on a line towards target
	#tries to hit anything in occupied cell with a bonus modifier for set target object.. 
	#return true #return true to end turn
