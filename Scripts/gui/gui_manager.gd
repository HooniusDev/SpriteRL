extends CanvasLayer
#gui_manager.gd

var pickup_button = preload("res://Scenes/gui/item_pickup_button.tscn")
var pickup_button_container
var pickup_buttons = []
var pickup_button_pos = Vector2( 32, 40 )
var pickup_button_gap = 25

var inventory_gui

func show_inventory():
	hide_pickup_buttons()
	inventory_gui.update_inventory_gui()
	inventory_gui.show()
	
func hide_inventory():
	show_pickup_buttons()
	inventory_gui.hide()

func _ready():
	globals.gui_controller = self
	pickup_button_container = get_node("pickup_buttons_container")
	pickup_button_container.set_pos( pickup_button_pos )
	inventory_gui = get_node("inventory_gui")
	pass

func hide_pickup_buttons():
	pickup_button_container.hide()

func show_pickup_buttons():
	pickup_button_container.show()
	
func _show_cell_item_pickup_buttons(cell_items):
	for button in pickup_buttons:
		button.queue_free()
	pickup_buttons.clear()

	if pickup_button_container != null:
		pickup_button_container.show()
	var count = 0
	if cell_items != null:
		for item in cell_items:
			var button = pickup_button.instance()
			pickup_buttons.append( button )
			pickup_button_container.add_child( button )

			button.set_name( str( count )+ "_" + item.get_name() )
			button.set_button_icon(item.get_node("sprite").get_texture())
			button.set_pos( Vector2( pickup_button_pos.x, pickup_button_pos.y + pickup_button_gap * count ))
			button.connect("button_up", self, "_on_pickup_button", [button,item])
			button.set_text( item.get_name() )
			
			count += 1
	pass

func _on_pickup_button(button,item ):
	for button in pickup_buttons:
		button.queue_free()
	pickup_buttons.clear()
	globals.player.pickup_item(item)
	

	
	
	
