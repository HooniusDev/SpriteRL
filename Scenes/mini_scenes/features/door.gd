extends Node2D

const TILESIZE = 16
const OPEN_FRAME = 5
const CLOSED_FRAME = 13

var is_open = true
var locked = false

var cell_pos setget cell_pos_set
func cell_pos_set( value ):
	cell_pos = value
	set_pos( value * TILESIZE )

func blocks_cell():
	if is_open:
		return false
	else:
		return self

func open():
	print ("opening door")
	if locked == false:
		is_open = true
		get_node("sprite").set_frame( OPEN_FRAME )
		get_node("occluder").set_hidden( true )
		get_parent().get_parent().set_passable(get_pos(), true )
		return true
	else:
		return false
		
func close():
	is_open = false
	get_node("sprite").set_frame( CLOSED_FRAME )
	get_node("occluder").set_hidden( false )
	get_parent().get_parent().set_passable(get_pos(), false )
	return true
	
func operate():
	if is_open:
		return close()
	else:
		return open()