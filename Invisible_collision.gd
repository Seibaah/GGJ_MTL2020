extends Area2D

var passed = false

func _on_RigidBody2D_body_entered(body):
	if !passed:
		var child = get_parent().get_child(1)
		child.play("falling")
		passed= true


