extends Control

var slot_lit = preload("res://Sprites/Atlas/gui/inventory_slot_lit.atex")
var slot_base = preload("res://Sprites/Atlas/gui/inventory_slot.atex")
var cell_scene = preload("res://Scenes/gui/inventory_cell.tscn")

var _active_slot = -1

var inventory_items
var equipped_items
var grid_node

func close_window():
	globals.player.inventory_shown = false
	hide()

func update_inventory_gui():
	_update_char_info()
	var items = globals.player.inventory.get_inventory()
	for i in range(grid_node.get_child_count()):
		#clear all data
		var grid_cell = grid_node.get_child(i)
		grid_cell.get_node("sprite").set_texture(null)
		grid_cell.set_tooltip("")
		grid_cell.get_node("sprite/count").set_text("")
		var item
		if i < items.size():
			item = items[i]
		else: 
			continue
			
		if item.has_method("get_description"):
			grid_cell.set_tooltip(item.get_description())
		else:
			grid_cell.set_tooltip(item.get_name())
			
		var source_node = item.get_node("sprite")

		grid_cell.get_node("sprite").set_texture(item.get_node("sprite").get_texture())
		
		if item.has_method("get_count"):
			grid_cell.get_node("sprite/count").set_text( str( item.get_count()))
		
	if globals.player.inventory._weapon != null:
		var _weapon = globals.player.inventory._weapon
		if _weapon.has_method("get_description"):
			equipped_items.get_node("weapon").set_tooltip(_weapon.get_description())
		else:
			equipped_items.get_node("weapon").set_tooltip(_weapon.get_name())
		var source_texture = _weapon.get_node("sprite").get_texture()
		equipped_items.get_node("weapon/sprite").set_texture(source_texture)
		var ammo = _weapon._ammo
		get_node("equipped_items/weapon/ammo").set_text( str(ammo))
		
	if globals.player.inventory._armour!= null:
		var _armour = globals.player.inventory._armour
		if _armour.has_method("get_description"):
			equipped_items.get_node("armour").set_tooltip(_armour.get_description())
		else:
			equipped_items.get_node("armour").set_tooltip(_armour.get_name())
		var source_texture = _armour.get_node("sprite").get_texture()
		equipped_items.get_node("armour/sprite").set_texture(source_texture)
		
	if globals.player.inventory._helmet!= null:
		var _helmet = globals.player.inventory._helmet
		if _helmet.has_method("get_description"):
			equipped_items.get_node("helmet").set_tooltip(_helmet.get_description())
		else:
			equipped_items.get_node("helmet").set_tooltip(_helmet.get_name())
		var source_texture = _helmet.get_node("sprite").get_texture()
		equipped_items.get_node("helmet/sprite").set_texture(source_texture)

		
func set_active_slot(index):
	for i in range(grid_node.get_child_count()):
		#grid_node.get_child(i).set_modulate( Color(1,1,1))
		grid_node.get_child(i).set_texture(slot_base)
	_active_slot = index
	if _active_slot != -1:
		#grid_node.get_child(_active_slot).set_modulate( Color(0,1,0))
		grid_node.get_child(_active_slot).set_texture(slot_lit)
	update_inventory_gui()

func _on_inventory_item_clicked(event, button):
	if event.is_action_released("mouse_left_up"):
			var item =  globals.player.inventory.get_item(button)
			if item == null:
				set_active_slot(-1)
				return
			if _active_slot != button:
				set_active_slot( button )
				return
			if item.is_in_group("ranged_weapon"):
				globals.player.inventory.ready_weapon( button )
				set_active_slot(-1)
				update_inventory_gui()
				return
			if item.is_in_group("armour") or item.is_in_group("helmet"):
				globals.player.inventory.wear( button )
				set_active_slot(-1)
				update_inventory_gui()
				return
			if item.has_method("use"):
				if item.is_in_group("ammunition"):
					item.use(globals.player.inventory._weapon)
				if item.is_in_group("usable_items"):
					item.use(globals.player)
				set_active_slot(-1)
				update_inventory_gui()
	if event.is_action_pressed("drop_item_modifier"):
				globals.player.drop_item(button)
				set_active_slot(-1)
				update_inventory_gui()
				return

func _ready():
	inventory_items = get_node("inventory_items")
	equipped_items = get_node("equipped_items")
	grid_node = get_node("inventory_items/grid")
	for i in range(30):
		var cell = cell_scene.instance()
		cell.set_texture(slot_base)
		cell.set_name(str(i))
		grid_node.add_child(cell)
		cell.connect("input_event", self, "_on_inventory_item_clicked", [i])
	get_node("close_button").connect("button_up", self, "close_window")
	pass
	
func _update_char_info():
	get_node("char_info/1st/name_container/name").set_text(globals.player.get_name())
	get_node("char_info/1st/health_container/health").set_text(str(globals.player.health_to_string()))
	get_node("char_info/1st/ac_container/ac").set_text(str(globals.player.get_ac()))