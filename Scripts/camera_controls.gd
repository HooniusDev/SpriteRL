#camera_controls.gd
extends Camera2D

var half_width
var half_height
var world_right_boundary = 0
var world_bottom_boundary = 0

func _ready():
	set_process_input(true)
	
func _focus_on_pos( pos ):
	if world_right_boundary == 0 or world_bottom_boundary == 0:
		print( "CAMERA NEEDS 'WORLD_BOUNDARIES'")
	if half_width == null:
		half_width = get_viewport_rect().size.width / 2
	if half_height == null:
		half_height = get_viewport_rect().size.height / 2
	if pos.x < half_width:
		pos.x = half_width
	if pos.y < half_height:
		pos.y = half_height
	if pos.x > world_right_boundary - half_width + 16:
		pos.x = world_right_boundary - half_width + 16
	if pos.y > world_bottom_boundary - half_height + 16:
		pos.y = world_bottom_boundary - half_height + 16
		 
	set_offset( pos )
	#print ( get_offset() )

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
		
