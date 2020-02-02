extends Sprite

func _input(event):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_RIGHT \
	and event.is_pressed()  and event.position == get_child(0).position:
		self.on_click() 

func on_click():
	print("clic")


func _on_CollisionShape2D_item_rect_changed():
	print("clic")
