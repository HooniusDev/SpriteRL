extends Node
#cell_position.gd
const TILESIZE = 16

var owner
var cell_pos
var type = "cell_position"

func set_cell(cell):
	cell_pos = cell
	if owner:
		owner.set_pos( cell * TILESIZE )
		
func get_cell():
	return cell_pos
	
func _on_added( owner ):
	print("cell_position added.")
	self.owner = owner
	owner.set_pos( cell_pos * TILESIZE )