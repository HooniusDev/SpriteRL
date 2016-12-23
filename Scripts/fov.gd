#fov.gd
var visible_tiles = []

func calculate2( map, pos, radius ):
	visible_tiles.clear()
	for i in range( -radius, radius ):
		for j in range( -radius, radius):
				if i*i+j*j < radius * radius:
					var los_blocked = false
					var line = []
					line = line( pos, Vector2(pos.x + i, pos.y + j))
					for cell in line:
						if !map.is_transparent( cell ):
							los_blocked = true
							visible_tiles.append(cell)
							break
						else:
							if los_blocked == false and !visible_tiles.has(cell):
								visible_tiles.append(cell)

func calculate( map, pos, radius ):
	
	visible_tiles.clear()
	
	var center = pos
	var rect = Rect2( Vector2(center.x- radius, center.y - radius), Vector2(radius*2 + 1,radius*2 + 1))
	var bounding_box = []
	
	var seen_tiles = []
	
	for y in range(0, rect.size.y,1):
		bounding_box.append( Vector2( center.x - radius, rect.pos.y + y) )
		bounding_box.append(Vector2( center.x + radius, rect.pos.y + y ) )
	for x in range(0, rect.size.x,1):
		bounding_box.append(Vector2(rect.pos.x + x, center.y - radius ) )
		bounding_box.append(Vector2(rect.pos.x + x, center.y + radius ) )
	
	for i in range(0, bounding_box.size(), 1):
		var los_blocked = false
		var line = []
		line = line( center , bounding_box[i] )
		for cell in line:
			if !map.is_transparent( cell ):
				los_blocked = true
				seen_tiles.append(cell)
				break
			else:
				if los_blocked == false and !seen_tiles.has(cell):
					seen_tiles.append(cell)
	visible_tiles = seen_tiles

	#return seen_tiles
	
func line(p0,p1):
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