extends TextureProgress

const red_bar = preload("res://Sprites/healtbar_red.png")
const green_bar = preload("res://Sprites/healtbar_green.png")

func _on_health_changed(value, max_value):
	set_max(max_value)
	set_value(value)
	if value<max_value:
		show()
	if value < get_max() * .25:
		set_progress_texture(red_bar)
	else:
		set_progress_texture(green_bar)

