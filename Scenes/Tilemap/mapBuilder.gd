extends Node2D

var size_x = 48
var size_y = 36

var parent

var floor_tiles #floors
var wall_tiles
var corridor_tiles

var _tile_data = {}

var TILE_FLOOR = 21
var TILE_WALL = 11
var TILE_CORRIDOR = 19
var TILE_DOOR = 17
var TILE_STAIRS_UP = 22

var boundaries = Rect2( 1,1, size_x-2, size_y-2 )

var min_room_size = 3
var max_room_size = 6

var max_rooms = 2
var tries_bailout = 140

var rooms = []

func build_map():
	randomize()
	create_start_room()
	var count = 0
	while true:
		#print("try a room " + str(rooms.size()) + ", " + str(count) )
		var size_x = floor(rand_range(min_room_size, max_room_size + 1))
		var size_y = floor(rand_range(min_room_size, max_room_size + 1))
		var pos_x = floor(rand_range(1, self.size_x-size_x))
		var pos_y = floor(rand_range(1, self.size_y-size_y))
		var room = Rect2( pos_x, pos_y, size_x, size_y)
		if not boundaries.encloses( room ):
			continue
		try_room( room )
		count += 1
		if count > tries_bailout or rooms.size()>=max_rooms:
			break
	for i in range( rooms.size()):
		#var start_pos = get_random_room_pos( i )
		var start_pos = Vector2 (rooms[i].pos.x + rooms[i].size.width / 2, rooms[i].pos.y + rooms[i].size.height / 2)
		
		var end_pos
		if i == rooms.size()-1:
			end_pos = Vector2 (rooms[0].pos.x + rooms[0].size.width / 2, rooms[0].pos.y + rooms[0].size.height / 2)
		else:
			end_pos = Vector2 (rooms[i+1].pos.x + rooms[i+1].size.width / 2, rooms[i+1].pos.y + rooms[i+1].size.height / 2)
		#parent.set_cellv( start_pos, 19 )
		#parent.set_cellv( end_pos, 19 )
		
		carve_tunnel_h(start_pos, end_pos.x )
		carve_tunnel_v(end_pos, start_pos.y )
		
		
	#connect_rooms()
	
func carve_tunnel_h( start_pos, end_x ):
	var x_min = min( start_pos.x, end_x )
	var x_max = max( start_pos.x, end_x )
	print( "tunnel_h min_max: " + str( Vector2(x_min,x_max)))
	for x in range( x_min, x_max + 1):
		#print( Vector2(x,start_pos.y) )
		set_cell( Vector2(x,start_pos.y), TILE_CORRIDOR )

func set_cell( pos, type ):
	if !_tile_data.has(pos):
		_tile_data[pos] = type
		parent.set_cellv( pos, type )
		return
	if _tile_data.has( pos ) and type == TILE_CORRIDOR:
		if _tile_data[pos] == TILE_FLOOR:
			return
		if _tile_data[pos] == TILE_WALL:
			_tile_data[pos] = TILE_DOOR
			parent.set_cellv( pos, TILE_DOOR )
			return

	
func carve_tunnel_v( start_pos, end_y ):
	var y_min = min( start_pos.y, end_y )
	var y_max = max( start_pos.y, end_y )
	print( "tunnel_v min_max: " + str( Vector2(y_min,y_max)))
	for y in range(y_min , y_max +1):
		set_cell(Vector2(start_pos.x, y), TILE_CORRIDOR )

func get_random_room_pos( room_id ):
	var x  = floor( rand_range(rooms[room_id].pos.x +1, rooms[room_id].end.x))
	var y  = floor( rand_range(rooms[room_id].pos.y +1, rooms[room_id].end.y))
	#parent.set_cellv( Vector2(x,y), 19 ) # DEBUG set tile to shallow_water
	return Vector2(x,y)
	
func create_start_room():
	carve_room( Rect2( 1,1,10,10 ) )
	set_cell( Vector2(5,5), TILE_STAIRS_UP)
	
func try_room( room_rect ):
	var expanded_room = room_rect.grow(2)
	for room in rooms:
		if room.intersects(expanded_room):
			#print ("rejected")
			return false

	#print("carve room" + str(room_rect))
	carve_room( room_rect )
		
	
func carve_room( _room ):
	var room = _room.grow(1)
	for x in range( room.pos.x, room.end.x+1 ):
		for y in range( room.pos.y, room.end.y+1 ):
			if x == room.pos.x or x == room.end.x or y == room.pos.y or y == room.end.y:
				set_cell( Vector2(x,y), TILE_WALL )
			else:
				set_cell( Vector2(x,y), TILE_FLOOR )
	rooms.append( _room )
	pass
	
func _enter_tree():
	randomize()
	parent = get_parent()
	if ( parent extends TileMap ):
		print ( "Building a map" )
		build_map()
	pass
	


