#base_action
extends Node2D

var type = "target_action"
var owner
var target
var msg = ""

func _init( owner, target = null ):
	self.owner = owner
	self.target = target


func perform():
	#get next target from visible enemies if target == null
	if typeof( target ) == TYPE_VECTOR2: #targetting a tile
		print ("targetting cell: " + str(target))
		return
	if target == "next":
#		if owner.targets.size() == 0:
#			owner.targets = globals.game_screen.get_targets( owner )
#		owner.target = (owner.target + 1) % owner.targets.size();
#		globals.world.highlight_tile( owner.targets[owner.target].tile_pos )
		print ("scanning for next target.." + str( owner.target ))
		return
	if target extends "mob.gd":
		print ("targetting cell: " + target.get_name())
		return
	print( "targetting failed.." )
