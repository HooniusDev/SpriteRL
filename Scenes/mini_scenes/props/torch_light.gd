extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func show():
	get_node("sprite/particles2d").set_time_scale( 0.2 )
	get_child(0).show()
	pass

func hide():
	get_node("sprite/particles2d").set_time_scale( 0 )
	pass

func _ready():
	get_child(0).hide()
	pass
