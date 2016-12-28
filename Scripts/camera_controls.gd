#camera_controls.gd
extends Camera2D

func _input(event):
	var cam_pos = get_offset()
	if event.is_action_released("move_camera_w"):
		set_offset( cam_pos + Vector2( -16,0 ))
	if event.is_action_released("move_camera_e"):
		set_offset( cam_pos + Vector2( 16,0 ))
	if event.is_action_released("move_camera_s"):
		set_offset( cam_pos + Vector2( 0,16 ))
	if event.is_action_released("move_camera_n"):
		set_offset( cam_pos + Vector2( 0,-16 ))
		
