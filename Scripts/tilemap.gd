extends TileMap

var fov = preload("res://Scripts/fov.gd")
var actual_fov
var visible_tiles = []
var passable_tiles = []
var transparent_tiles = []
var TILE_DATA = {}

var FLOOR = 21
var WATER_SHALLOW = 19
var WATER_DEEP = 20
var HIDDEN = 33

# tilemap knows if passable or not... if passable->floor else >wall
onready var mouse_label = get_node("../gui/mouse_pos_label")
onready var camera = get_node("camera")
var prev_mouse_cell

func _ready():
	actual_fov = fov.new()
	set_process_input( true )
	var tile_array = get_used_cells()
	var tileset = get_tileset()
	for cell in tile_array:
		var tiletype =  get_cellv( cell )
		var tilename = tileset.tile_get_name( tiletype )
		set_tile( cell, tiletype, tilename )
		
	print (TILE_DATA.size() )
	
	pass
	
func set_tile( cell, tiletype, tilename ):
	#tiletype is int and refers to tile id in tileset
	#tilename is name of the tiletype in tileset
	if tiletype == FLOOR:
		passable_tiles.append( cell )
		transparent_tiles.append( cell )  
		TILE_DATA[cell] = get_cellv( cell )
		set_cellv( cell, HIDDEN )
		return
	if tiletype == WATER_DEEP:
		#passable_tiles.append( cell )
		transparent_tiles.append( cell )  
		TILE_DATA[cell] = get_cellv( cell )
		set_cellv( cell, HIDDEN )
		return
	if tiletype == WATER_SHALLOW:
		passable_tiles.append( cell )
		transparent_tiles.append( cell )  
		TILE_DATA[cell] = get_cellv( cell )
		set_cellv( cell, HIDDEN )
		return
	#passable_tiles.append( cell )
	#transparent_tiles.append( cell )  
	TILE_DATA[cell] = get_cellv( cell )
	set_cellv( cell, HIDDEN )
		
	pass

func is_passable( cell ):
	if passable_tiles.has( cell ):
		return true
	else:
		return false
		
func is_transparent( cell ):
	if transparent_tiles.has( cell ):
		return true
	else:
		return false
		
func _input(event):
	var mouse_pos = world_to_map( get_global_mouse_pos() )
	if (TILE_DATA.has(mouse_pos) and mouse_pos != prev_mouse_cell ):
		var tiletype = get_cell( mouse_pos.x, mouse_pos.y )
		var tilename = get_tileset().tile_get_name( tiletype )
		# move label to top left corner
		#mouse_label.set_global_pos( Vector2( camera.get_offset().x - camera.get_viewport_rect().size.width / 2,  camera.get_offset().y - camera.get_viewport_rect().size.height / 2 ))
		mouse_label.text = tilename
		prev_mouse_cell = mouse_pos
		var explored = get_node("explored")

		for cell in visible_tiles:
			explored.set_cellv( cell, 29 )
			#set_cellv( cell, 33 )
			
		visible_tiles.clear()
		visible_tiles = actual_fov.get_fov( self, mouse_pos, 3 )
		for cell in visible_tiles:
			if ( TILE_DATA.has(cell)):
				explored.set_cellv( cell, -1 )
				set_cellv( cell, TILE_DATA[cell] )