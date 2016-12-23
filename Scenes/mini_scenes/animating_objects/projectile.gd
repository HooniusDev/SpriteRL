
extends Node2D

var tile_pos
var target
var path = []
var path_step = 0
var _range
var _damage

func set_properties( _range, _damage ):
	self._range = _range
	self._damage = _damage

func initialize( tile_pos, target ):
	self.tile_pos = tile_pos
	self.target = target
	if typeof(target) == TYPE_VECTOR2:
		path = utils.get_line( tile_pos, target )
	else: # is a target mob so get -> target.tile_pos
		path = utils.get_line( tile_pos, target.tile_pos )

func move(  ):
	path_step += 1
	tile_pos = path[path_step]
	#var result = globals.world.is_passable( tile_pos )
	var result
	if typeof(result) == TYPE_BOOL:
		if result == true: # is floor
			print( "passes thin ait" )
			#set_pos(globals.world.map_to_world(tile_pos))
			return
		elif result == false: # is something else
			print("hit a wall." + str(tile_pos))
			_range = 0
			#globals.game_screen.deregister_animating_object( self )
			return
	if result.has_method("damage"):
		result.damage(_damage)
		_range = 0
		#globals.game_screen.deregister_animating_object( self )
		

func perform():
	move( )
	_range -= 1
	if _range > 0:
		return false
	elif _range == 0:
		queue_free()
		#globals.world.highlight_tile(tile_pos)
		#get_node("/root/game_screen").deregister_animating_object( self )
		return true
	pass



