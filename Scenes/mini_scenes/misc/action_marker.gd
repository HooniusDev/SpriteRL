extends Sprite

const CURSOR_N = preload("res://Sprites/Atlas/gui/mouse_n.atex")
const CURSOR_NE = preload("res://Sprites/Atlas/gui/mouse_ne.atex")
const CURSOR_E = preload("res://Sprites/Atlas/gui/mouse_e.atex")
const CURSOR_SE = preload("res://Sprites/Atlas/gui/mouse_se.atex")
const CURSOR_S = preload("res://Sprites/Atlas/gui/mouse_s.atex")
const CURSOR_SW = preload("res://Sprites/Atlas/gui/mouse_sw.atex")
const CURSOR_W = preload("res://Sprites/Atlas/gui/mouse_w.atex")
const CURSOR_NW = preload("res://Sprites/Atlas/gui/mouse_nw.atex")
const CURSOR_SHOOT = preload("res://Sprites/Atlas/gui/crosshair.atex")

const cursors = [CURSOR_N,CURSOR_NE,CURSOR_E,CURSOR_SE,CURSOR_S,CURSOR_SW,CURSOR_W,CURSOR_NW]

var label

func show_arrow( dir ):
	show()
	set_texture( cursors[dir] )
	
func show_crosshair(pos):
	show()
	set_offset(pos)
	set_texture(CURSOR_SHOOT)

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	hide()
	label = get_node("label")
	pass
