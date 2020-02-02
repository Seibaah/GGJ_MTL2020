extends Node2D

func _on_RigidBody2D_body_entered(body):
	$RigidBody2D/AnimatedSprite.play("final")
	
	
	$RigidBody2D/AnimatedSprite.visible = true
	$RigidBody2D/AnimatedSprite2.visible = true
	$RigidBody2D/AnimatedSprite3.visible = true
	$RigidBody2D/AnimatedSprite4.visible = true
	$RigidBody2D/AnimatedSprite5.visible = true
	$RigidBody2D/AnimatedSprite6.visible = true
	$RigidBody2D/AnimatedSprite7.visible = true
	$RigidBody2D/AnimatedSprite8.visible = true
	$RigidBody2D/AnimatedSprite9.visible = true
	
	
	$RigidBody2D/AnimatedSprite2.play("final")
	$RigidBody2D/AnimatedSprite3.play("final")
	$RigidBody2D/AnimatedSprite4.play("final")
	$RigidBody2D/AnimatedSprite5.play("final")
	$RigidBody2D/AnimatedSprite6.play("final")
	$RigidBody2D/AnimatedSprite7.play("final")
	$RigidBody2D/AnimatedSprite8.play("final")
	$RigidBody2D/AnimatedSprite9.play("final")
