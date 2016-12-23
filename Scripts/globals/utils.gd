#utils.gd
extends Node

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