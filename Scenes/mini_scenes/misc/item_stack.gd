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
	# Called every time the node is added to the scene.
	# Initialization here
	pass
