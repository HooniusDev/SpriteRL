extends Node2D

var life_time = 1
var move_speed = 10

func create(text, color = null):
	get_node("Label").set_text(str(text))
	if color != null:
		get_node("Label").add_color_override("font_color", Color(0,1,0))
	
func _process(delta):
	life_time -= delta
	set_pos( get_pos() - Vector2(0, move_speed*delta))
	if life_time < 0:
		queue_free()

func _ready():
	set_process(true)
	pass
	
	
