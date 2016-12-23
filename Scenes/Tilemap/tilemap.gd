extends TileMap

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var size_x = 40
var size_y = 40

var is_passable = {}
var is_transparent = {}
var is_explored = {}
var is_fov = {}

func _ready():
	
	pass

func is_passable_v( v ):
	if is_passable.has( v ):
		return is_passable[v]
	else:
		return false
	pass
	
func is_transparent_v( v):
	if is_transparent.has( v ):
		return is_transparent[v]
	else:
		return false
	pass
	
func is_explored_v( v):
	if is_explored.has( v ):
		return is_explored[v]
	else:
		return false
	pass
	
func set_tile( x, y, passable, transparent ):
	if typeof( passable ) != TYPE_BOOL or typeof( transparent ) != TYPE_BOOL:
		printerr (" passable and transparent need to be booleans! ")
		return
	is_passable[Vector2(x,y)] = passable
	is_transparent[Vector2(x,y)] = transparent

func set_tile_type( x,y, type ):
	set_cell( x,y, type )
	pass