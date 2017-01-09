#utils.gd
extends Node

const damage_label = preload("res://Scenes/mini_scenes/misc/damage_label.tscn")

var map_manager

static func resolve_shot( attacker, target ):
	print("resolving shot....")
	print("You hit the: " + target.get_name() + "for " + str(attacker.inventory._weapon._damage)) 
	target.take_damage( attacker.inventory._weapon._damage )
	return #damage

func on_damage( pos, amount ):
	var label = damage_label.instance()
	label.set_pos( Vector2( pos.x + 6, pos.y - 8 ))
	map_manager.add_child( label )
	label.create(amount)
	pass
	
func on_heal( pos, amount ):
	var label = damage_label.instance()
	label.set_pos( Vector2( pos.x + 8, pos.y - 8 ))
	map_manager.add_child( label )
	label.create(amount, Color(1,0,0))
	pass

func check_los( p0, radius):
	var line = get_line( p0, map_manager.player.cell_pos)
	var distance = 0
	for cell in line:
		if distance > radius:
			return false
		if !map_manager.is_transparent(cell):
			return false
		distance += 1
	return line[1]
	
func get_move_dir( p0, p1 ):
	var line = get_line( p0, p1)
	return line[1]

func get_line(p0,p1):
	var points = []
	var N = diagonal_distance(p0,p1)
	for step in range(0, N + 1, 1):
		var t
		if N == 0:
			t = 0
		else:
			t = step / N
		points.append(round_point(lerp_point(p0,p1,t)))
	return points

func diagonal_distance(p0, p1):
	var dx = p1.x - p0.x
	var dy = p1.y - p0.y
	return max( abs(dx), abs(dy))
	
func round_point(p):
	return Vector2(round(p.x), round(p.y))
	
func lerp_point(p0,p1,t):
	return Vector2(lerp(p0.x, p1.x, t), lerp(p0.y, p1.y, t))

func add_shadows(tile_data, transparent_cells):
	
	var SHADOW = 30
	var SHADOW_SMALL = 31
	var SHADOW_LEFT = 32
	var SHADOW_CORNER = 33
	var SHADOW_OUTER_CORNER = 34
	var SHADOW_SMALL_LEFT = 35
	
	var shadow_data = {}
	var cells = tile_data.keys()
	for cell in cells:
		if tile_data[cell] == 21: # is floor
			var north = directions.get_north(cell)
			var east = directions.get_east(cell)
			var wall_north = false
			var wall_east = false
			if tile_data.has(east) and !transparent_cells.has(east):
				shadow_data[ cell ] = SHADOW_LEFT
				wall_east = true
			if tile_data.has(north) and !transparent_cells.has(north):
				shadow_data[ cell ] = SHADOW
				wall_north = true
			if wall_east and wall_north:
				shadow_data[ cell ] = SHADOW_CORNER
				continue
			var ne = cell + directions.NE
			if !wall_east and !wall_north and tile_data.has(ne) and !transparent_cells.has(ne):
				shadow_data[ cell ] = SHADOW_OUTER_CORNER
				continue
	return shadow_data