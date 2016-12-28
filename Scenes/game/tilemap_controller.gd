extends TileMap

#TILEMAP ID_S
const FLOOR = "floor"
const WATER_SHALLOW = "water_shallow"
const WATER_DEEP = "water_deep"
const HIDDEN = -1
const EXPLORED = 29
const STAIRS_DOWN = "stairs_down"
const STAIRS_UP  = "stairs_up"
const DOOR_OPEN = "door_open"
const DOOR_CLOSED = "door_closed"

var _shadow_data = {}
var _tile_data = {}
var _map_bounds

var stairs_up

var _passable_cells = []
var _transparent_cells = []

var _objects = {} #key: cell_pos, value object array
var _actors = {} #key: cell_pos, value actor

var shadows_layer
var explored_layer

var player

func _ready():
	shadows_layer = get_node("shadows_layer")
	explored_layer = get_node("explored_layer")
	
	var tile_array = get_used_cells() 
	var tileset = get_tileset()
	var min_x = 0
	var min_y = 0
	var max_x = 0
	var max_y = 0
	for cell in tile_array: #set map max x and y
		if cell.x > max_x:
			max_x = cell.x
		if cell.x < min_x:
			min_x = cell.x
		if cell.y > max_y:
			max_y = cell.y
		if cell.y < min_y:
			min_y = cell.y
		var tiletype =  get_cellv( cell )
		var tilename = tileset.tile_get_name( tiletype )
		set_tile( cell, tilename ) # get tiledata from tilemap and copy it to TILE_DATA before hiding the map
	#_add_decals()
	_shadow_data = utils.add_shadows(_tile_data, _transparent_cells)
	
	get_parent().set_map(self)
	
	for actor in get_node("actors").get_children():
		set_actor_pos( actor, actor.cell_pos )
		if actor.is_in_group("player"):
			player = actor
			
	set_actor_pos( player, stairs_up )
	get_parent().update_fov( player.cell_pos, player.sight_radius )

func is_transparent(cell):
	return _transparent_cells.has(cell)

func is_passable(cell):
	return _passable_cells.has(cell)
	
func set_actor_pos(actor, new_pos):
	if !is_passable( new_pos ):
		return false
	if _actors.has(actor.cell_pos):
		_actors.erase(actor.cell_pos)
		_passable_cells.append(actor.cell_pos)
	_actors[new_pos] = actor
	_passable_cells.erase(new_pos)
	actor.cell_pos = new_pos
	return true

func show_cell(cell):
	if ( _tile_data.has(cell)):
		explored_layer.set_cellv( cell, -1 ) # Hide fog
		set_cellv( cell, _tile_data[cell] ) # Show original tile
		if _shadow_data.has(cell):
			shadows_layer.set_cellv( cell, _shadow_data[cell]) # show decals
		if _objects.has(cell):
			for object in _objects[cell]:
				if object.has_method("show"):
					object.show()
		if _actors.has(cell):
			if _actors[cell].has_method("show"):
				_actors[cell].show()
	pass

func hide_cell(cell):
	if _tile_data.has(cell):
		explored_layer.set_cellv( cell, EXPLORED )
		if _objects.has(cell):
			for object in _objects[cell]:
				if object.has_method("hide"):
					object.hide()
	pass
	
func set_tile( cell, tilename ):
	#tiletype is int and refers to tile id in tileset
	#tilename is name of the tiletype in tileset
	if tilename == FLOOR:
		_passable_cells.append( cell )
		_transparent_cells.append( cell )  
		_tile_data[cell] = get_cellv( cell )
		.set_cellv( cell, HIDDEN )
		return
	if tilename == WATER_DEEP:
		_passable_cells.append( cell )  
		_tile_data[cell] = .get_cellv( cell )
		set_cellv( cell, HIDDEN )
		return
	if tilename == WATER_SHALLOW:
		_passable_cells.append( cell )
		_transparent_cells.append( cell )  
		_tile_data[cell] = get_cellv( cell )
		set_cellv( cell, HIDDEN )
		return
	if tilename == STAIRS_DOWN or tilename == STAIRS_UP:
		_passable_cells.append( cell )
		_transparent_cells.append( cell )  
		_tile_data[cell] = get_cellv( cell )
		set_cellv( cell, HIDDEN )
		if tilename == STAIRS_UP:
			stairs_up = cell
		return
	if tilename == DOOR_CLOSED or tilename == DOOR_OPEN:
		#var door = door_prefab.instance()
		#features.add_child(door)
		#door.close()
		#door.cell_pos = cell
		#door.set_pos( Vector2( cell.x * 16, cell.y * 16) )
		_passable_cells.append(cell)
		_transparent_cells.append(cell)
		_tile_data[cell] = 21
		set_cellv( cell, HIDDEN )
		return

	# REST ARE WALLS
	_tile_data[cell] = get_cellv( cell )
	set_cellv( cell, HIDDEN )
		
	pass