extends Node2D

var size_x = 40
var size_y = 40

var parent

var TILE_FLOOR = 0
var TILE_WALL = 1
var TILE_CORRIDOR = 2
var TILE_STAIRS_UP = 3

var boundaries = Rect2( 0,0, size_x, size_y )

var min_room_size = 3
var max_room_size = 6

var max_rooms = 20

var rooms = []

func build_map():
	var size_x = floor(rand_range(min_room_size, max_room_size + 1))
	var size_y = floor(rand_range(min_room_size, max_room_size + 1))
	var pos_x = floor(rand_range(0, self.size_x-size_x))
	var pos_y = floor(rand_range(0, self.size_y-size_y))
	var room = Rect2( pos_x, pos_y, size_x, size_y)
	carve_room( room )
	pass
	
func carve_room( room ):
	for x in range( room.pos.x, room.pos.x + room.size.width ):
		for y in range( room.pos.y, room.pos.y + room.size.height ):
			parent.set_tile_type( x,y, TILE_FLOOR )
	pass
	
func _enter_tree():
	randomize()
	parent = get_parent()
	if ( parent extends TileMap ):
		print ( "Building a map" )
		build_map()
	pass

