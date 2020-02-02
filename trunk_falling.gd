extends Node2D


func _on_RigidBody2D_body_entered(body):
	print("test")
	$AnimationPlayer.play("falling")
	


func _on_RigidBody2D_body_exited(body):
	$AnimationPlayer.stop()
