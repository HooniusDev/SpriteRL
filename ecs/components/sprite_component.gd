extends Sprite

var type = "sprite"
var owner

func _on_added( owner ):
	print("Sprite_component added")
	self.owner = owner
	owner.add_child(self)
	pass