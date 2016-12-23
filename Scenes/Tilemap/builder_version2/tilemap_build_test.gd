extends TileMap

var DOOR = 15

var visited_cells = []
var current_area_array = []
var current_area = 0
var areas = {}

func _ready():
	var cells = get_used_cells()
	var current_cell_id
	for cell in cells:
		current_cell_id = get_cellv( cell )
		print(current_cell_id)
		if visited_cells.has(cell):
			continue
		else:
			#visited_cells.append(cell)
			flood_fill( cell, current_cell_id, current_area )
			areas[current_area] = current_area_array
			current_area += 1
	
	pass
	
func flood_fill( cell, cell_id, current_area ):
	print( "tadaa" )
	if get_cellv( cell ) != cell_id:
		return
	visited_cells.append(cell)
	current_area_array.append(cell)
	#flood_fill( directions.get_north( cell ), cell_id, current_area )
	#flood_fill( directions.get_east( cell ), cell_id, current_area )
	#flood_fill( directions.get_south( cell ), cell_id, current_area )
	#flood_fill( directions.get_west( cell ), cell_id, current_area )
	pass


func get_neighbours(pos):
	var neighbours = []
	neighbours.append( directions.get_north( pos ))
	neighbours.append( directions.get_east( pos ))
	neighbours.append( directions.get_south( pos ))
	neighbours.append( directions.get_west( pos ))
	return neighbours