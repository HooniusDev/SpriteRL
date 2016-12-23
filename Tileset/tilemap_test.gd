extends TileMap

var FLOOR = "floor"
var WATER_SHALLOW = "water_shallow"
var WATER_DEEP = "water_deep"
var HIDDEN = -1
var EXPLORED = 29
var STAIRS_DOWN = "stairs_down"
var STAIRS_UP  = "stairs_up"
var DOOR_OPEN = "door_open"
var DOOR_CLOSED = " door_closed"

var TILE_DATA = {}
var DECAL_DATA = {}
var passable_tiles = []
var transparent_tiles = []

var stairs_up

var explored_layer
var decals_layer

var SHADOW = 30
var SHADOW_SMALL = 31
var SHADOW_LEFT = 32
var SHADOW_CORNER = 33
var SHADOW_OUTER_CORNER = 34
var SHADOW_SMALL_LEFT = 35

var max_x = 0
var max_y = 0


func show_cell( cell ):
	if ( TILE_DATA.has(cell)):
		explored_layer.set_cellv( cell, -1 ) # Hide fog
		set_cellv( cell, TILE_DATA[cell] ) # Show original tile
		if DECAL_DATA.has(cell):
			decals_layer.set_cellv( cell, DECAL_DATA[cell]) # show decals
		var objects = get_node("objects").get_children()
		for object in objects:
			if cell == world_to_map( object.get_pos() ):
				object.show()
	pass
	
func hide_cell( cell ):
	if TILE_DATA.has(cell):
		explored_layer.set_cellv( cell, EXPLORED )
		var objects = get_node("objects").get_children()
		for object in objects:
			if cell == world_to_map( object.get_pos() ):
				object.hide()
	pass

func _ready():
	explored_layer = get_node("explored")
	decals_layer = get_node("decals")
	
	var tile_array = get_used_cells()
	var tileset = get_tileset()
	for cell in tile_array:
		if cell.x > max_x:
			max_x = cell.x
		if cell.y > max_y:
			max_y = cell.y
		var tiletype =  get_cellv( cell )
		var tilename = tileset.tile_get_name( tiletype )

		set_tile( cell, tilename )
		
	_add_decals()

	var parent = get_parent()
	if (parent!= null):
		parent.tilemap = self
	
	pass
	
func set_tile( cell, tilename ):
	#tiletype is int and refers to tile id in tileset
	#tilename is name of the tiletype in tileset
	if tilename == FLOOR:
		passable_tiles.append( cell )
		transparent_tiles.append( cell )  
		TILE_DATA[cell] = get_cellv( cell )
		.set_cellv( cell, HIDDEN )
		return
	if tilename == WATER_DEEP:
		transparent_tiles.append( cell )  
		TILE_DATA[cell] = .get_cellv( cell )
		set_cellv( cell, HIDDEN )
		return
	if tilename == WATER_SHALLOW:
		passable_tiles.append( cell )
		transparent_tiles.append( cell )  
		TILE_DATA[cell] = get_cellv( cell )
		set_cellv( cell, HIDDEN )
		return
	if tilename == STAIRS_DOWN or tilename == STAIRS_UP or tilename == DOOR_OPEN:
		passable_tiles.append( cell )
		transparent_tiles.append( cell )  
		TILE_DATA[cell] = get_cellv( cell )
		set_cellv( cell, HIDDEN )
		if tilename == STAIRS_UP:
			stairs_up = cell
		return
	if tilename == DOOR_CLOSED: 
		TILE_DATA[cell] = get_cellv( cell )
		set_cellv( cell, HIDDEN )
		return

	# REST ARE WALLS
	TILE_DATA[cell] = get_cellv( cell )
	set_cellv( cell, HIDDEN )
		
	pass
	
func is_transparent(cell):
	if TILE_DATA.has( cell ) and passable_tiles.has( cell ):
		return true
	else:
		return false
	
func _is_valid( cell ):
	if TILE_DATA.has(cell):
		return true
	else:
		return false
		
func _add_decals():
	var cells = TILE_DATA.keys()
	var tileset = get_tileset()
	for cell in cells:
		var tilename = tileset.tile_get_name( TILE_DATA[cell] )
		if tilename == FLOOR:
			var north = directions.get_north(cell)
			var east = directions.get_east(cell)
			var wall_north = false
			var wall_east = false
			if  _is_valid( east ) and !transparent_tiles.has(east):
				DECAL_DATA[ cell ] = SHADOW_LEFT
				wall_east = true
			if _is_valid( north ) and !transparent_tiles.has(north):
				DECAL_DATA[ cell ] = SHADOW
				wall_north = true
			if wall_east and wall_north:
				DECAL_DATA[ cell ] = SHADOW_CORNER
				continue
			var ne = cell + directions.NE
			if !wall_east and !wall_north and _is_valid(ne) and !transparent_tiles.has(ne):
				DECAL_DATA[ cell ] = SHADOW_OUTER_CORNER
				continue
			if tileset.tile_get_name( TILE_DATA[ north ] ) == STAIRS_UP :
				DECAL_DATA[ cell ] = SHADOW_SMALL
			if tileset.tile_get_name( TILE_DATA[ east ] ) == STAIRS_UP :
				DECAL_DATA[ cell ] = SHADOW_SMALL_LEFT

	pass
