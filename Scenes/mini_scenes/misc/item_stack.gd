extends Node2D

var _items = []
var holder

func get_items():
	return _items
	
func get_count():
	return _items.size()

func add_item(item):
	item.set_pos(Vector2(0,0))
	for i in _items:
		i.hide()
	_items.append(item)
	if item.get_parent() != null:
		item.get_parent().remove_child(item)
	holder.add_child(item)
	if _items.size() > 1:
		get_node("count").show()
		get_node("count").set_text(str(_items.size()))
	print("item stack (" + get_name() + "): "+ str( _items.size() ))
	_items[_items.size()-1].show()
	
func remove_item(item):
	_items.erase(item)
	holder.remove_child(item)
	if _items.size() == 0:
		queue_free()
	else:
		if _items.size() == 1:
			get_node("count").hide()
		get_node("count").set_text(str(_items.size()))
		_items[_items.size()-1].show()
	


func _ready():
	holder = get_node("holder")
	#get_node("control").connect("mouse_enter",self,"_on_mouse_enter")
	#get_node("control").connect("mouse_exit",self,"_on_mouse_exit")
	pass

#func _on_mouse_enter():
#	set_z( 10 )
#	var c = get_node("control")
#	var font = load("res://Sprites/font/8font.fnt")
#	var text = ""
#	var count = 0
#	for item in _items:
#		var label = load("res://Scenes/gui/label.tscn").instance()
#		c.add_child(label)
#		#label.add_font_override( "8font", font )
#		label.set_text(item.get_name())
#		label.set_pos( Vector2( 16, count * 12 ))
#		count += 1
#
#func _on_mouse_exit():
#	set_z(0)
#	var c = get_node("control")
#	for child in c.get_children():
#		child.queue_free()

