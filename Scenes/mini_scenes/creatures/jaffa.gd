extends Node2D

const TILESIZE = 16

var prev_dir

var energy = -1
var energy_regen = .7
	
	
var cell_pos setget cell_pos_set
func cell_pos_set( value ):
	cell_pos = value
	set_pos( value * TILESIZE )

func get_action():
	return action_factory.new_move( self, directions.get_random() )

func _ready():
	cell_pos = get_pos() / TILESIZE
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func blocks_cell():
	return self
