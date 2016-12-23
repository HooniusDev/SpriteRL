#global.gd

extends Node

var N setget ,_north
func _north():
	return Dir.N
var NE setget ,_northeast
func _northeast():
	return Dir.NE
var E setget ,_east
func _east():
	return Dir.E
var SE setget ,_southeast
func _southeast():
	return Dir.SE
var S setget ,_south
func _south():
	return Dir.S
var SW setget ,_southwest
func _southwest():
	return Dir.SW
var W setget ,_west
func _west():
	return Dir.W
var NW setget ,_northwest
func _northwest():
	return Dir.NW
	
func get_north( pos ):
	return pos + _north()
func get_east( pos ):
	return pos + _east()
func get_south( pos ):
	return pos + _south()
func get_west( pos ):
	return pos + _west()


	
const Direction = {
	N = Vector2( 0, -1 ),
	NE = Vector2( 1, -1 ),
	E = Vector2( 1, 0 ),
	SE = Vector2( 1, 1 ),
	S = Vector2( 0, 1 ),
	SW = Vector2( -1, 1 ),
	W = Vector2( -1, 0 ),
	NW = Vector2( -1, -1 )
}
	
class Dir:
	const N = Vector2( 0, -1 )
	const NE = Vector2( 1, -1 )
	const E = Vector2( 1, 0 )
	const SE = Vector2( 1, 1 )
	const S = Vector2( 0, 1 )
	const SW = Vector2( -1, 1 )
	const W = Vector2( -1, 0 )
	const NW = Vector2( -1, -1 )


