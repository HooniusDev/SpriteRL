#map_controller

#####################################
#	gets a child tilemap and reads its contents.
#	maintains tilemap state
#####################################
extends Node2D

var fov = preload("res://Scripts/fov.gd")

var player

var tilemap setget tilemap_set
func tilemap_set(newvalue):
	tilemap=newvalue
	init()
	spawn_player( tilemap.stairs_up )
	update_fov( tilemap.world_to_map( player.get_pos() ), 15 )



func init():
	fov = fov.new()
	camera = get_node("camera")
	camera.world_right_boundary = tilemap.max_x * 16
	camera.world_bottom_boundary = tilemap.max_y * 16
	pass

onready var mouse_label = get_node("../gui/mouse_pos_label")
var camera
var prev_mouse_cell

func is_passable( cell ):
	if tilemap.passable_tiles.has( cell ):
		var creatures = get_node("tilemap/creatures").get_children()
		for c in creatures:
			if cell == tilemap.world_to_map( c.get_pos()):
				return false
		return true
	else:
		return false

func is_transparent( cell ):
	if tilemap.transparent_tiles.has( cell ):
		return true
	else:
		return false

func spawn_player(cell):
	player = load("res://Scenes/mini_scenes/creatures/player.tscn").instance()
	get_node("tilemap/creatures").add_child(player)
	player.set_pos( tilemap.map_to_world(cell))
	camera._focus_on_pos(player.get_pos())

func _ready():
	set_process_input( true )
	pass
	
func _input(event):
	#show the mouse position
	var mouse_pos = tilemap.world_to_map( get_global_mouse_pos() )
	if (tilemap.TILE_DATA.has(mouse_pos) and fov.visible_tiles.has(mouse_pos) and mouse_pos != prev_mouse_cell ):
		var tiletype = tilemap.get_cellv( mouse_pos )
		var tilename = tilemap.get_tileset().tile_get_name( tiletype )
		mouse_label.text = tilename + str( mouse_pos )
		prev_mouse_cell = mouse_pos

func _set_cell_visible(cell):
	tilemap.show_cell(cell)
	pass

func _set_cell_hidden(cell):
	tilemap.hide_cell(cell)
	pass

func update_fov( pos, radius ):
	
	#old visible tiles gets to be "explored"
	for cell in fov.visible_tiles:
		_set_cell_hidden(cell)

	fov.calculate2( self, pos, radius )
	
	for cell in fov.visible_tiles:
		_set_cell_visible(cell)
			
	var creatures = get_node("tilemap/creatures").get_children()
	var objects = get_node("tilemap/objects").get_children()
	
	for creature in creatures:
		if fov.visible_tiles.has( tilemap.world_to_map( creature.get_pos() ) ):
			creature.show()
				
	for object in objects:
		if fov.visible_tiles.has( tilemap.world_to_map( object.get_pos() ) ):
			object.show()

func on_creature_move( creature ):
	if fov.visible_tiles.has( tilemap.world_to_map( creature.get_pos() ) ):
		creature.show()
	else:
		creature.hide()
	pass
	
func on_player_enter_cell(player):
	camera._focus_on_pos( player.get_pos()) 
	var tiletype = tilemap.get_cellv( tilemap.world_to_map( player.get_pos() ) )
	var tilename = tilemap.get_tileset().tile_get_name( tiletype )
	
	var objects = get_node("tilemap/objects").get_children()
	var text = 'there are things: '
	if objects.size() > 0:
		for o in objects:
			if o.get_pos() == player.get_pos():
				text += o.get_name()
				text += ", "
		if text != 'there are things: ':
			print(text)
	
	if ( tilename != tilemap.FLOOR ):
		print( tilename )

func on_player_move( player, target ):
	if is_passable( tilemap.world_to_map(target)):
		player.set_pos( target )
		update_fov( tilemap.world_to_map( player.get_pos() ), 15 )
		on_player_enter_cell(player)
	else:
		print( "Blocked!" )
	pass

