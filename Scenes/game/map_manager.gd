extends Node2D

var fov = preload("res://Scripts/fov.gd")

var _tilemap

var player

func update_fov( pos, radius ):
	
	#old visible tiles gets to be "explored"
	for cell in fov.visible_tiles:
		set_cell_visibility(cell, false)

	fov.calculate2( self, pos, radius )
	
	#print ( "visible cells: " + str( fov.visible_tiles ))
	
	for cell in fov.visible_tiles:
		set_cell_visibility(cell, true)

func move_actor(actor, new_pos):
	if _tilemap.set_actor_pos(actor, new_pos):
		if actor.is_in_group("player"):
			update_fov( actor.cell_pos, actor.sight_radius )
			return
	if fov.visible_tiles.has( actor.cell_pos ):
		if actor.has_method("set_in_player_sight"):
			actor.set_in_player_sight(true)
		actor.show()
	else:
		if actor.has_method("set_in_player_sight"):
			actor.set_in_player_sight(false)
	#	actor.hide()

func set_map(tilemap):
	_tilemap = tilemap
	fov = fov.new()
	#spawn_player( tilemap.stairs_up )
	if player != null:
		update_fov( player.cell_pos, player.sight_radius )

func is_passable(cell):
	return _tilemap.is_passable(cell)

func get_blocker(cell):
	return _tilemap.get_blocker(cell)

func is_transparent(cell):
	return _tilemap.is_transparent(cell)
	
func set_cell_visibility(cell, visible = true):
	if visible:
		_tilemap.show_cell(cell)
	else:
		_tilemap.hide_cell(cell)

func _ready():
	utils.map_manager = self
	
	pass
