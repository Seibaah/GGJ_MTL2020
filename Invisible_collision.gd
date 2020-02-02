extends RigidBody2D



func _on_RigidBody2D_body_entered(body):
	print("test")
	var child = get_parent().get_child(6).get_child(1)
	print(child)


func _on_RigidBody2D_body_shape_entered(body_id, body, body_shape, local_shape):
	print("test")
	get_parent().get_child(6).get_child(1).play("falling")
