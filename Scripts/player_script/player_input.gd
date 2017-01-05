extends Node

#if item with target needed is used or entered shoot mode
#on mouse -> 
const MODE_CHOOSE_TARGET = 0
#on mouse -> move
const MODE_MOVE = 1

#draw targetting rect? show tooltip of enemy info
#try shoot or melee, move otherwise
const MOUSE_OVER_HOSTILE = 1 
 #get cell next to player and show move marker if valid move
const MOUSE_OVER_NULL_TILE = -1
 #get cell next to player and show marker if valid move. tooltip 'wall'
const MOUSE_OVER_WALL_TILE = 2
#get cell next to player and show move marker if valid move.
#tooltip 'floor' if no items else tootip 'item name array'
const MOUSE_OVER_FLOOR_TILE = 3 


var mode 

func _ready():

	pass
