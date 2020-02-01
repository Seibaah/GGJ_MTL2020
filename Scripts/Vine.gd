extends KinematicBody2D


onready var anim_player = $AnimationPlayer


func _physics_process(delta):
	#plant_seed
	if Input.is_action_pressed("plant_seed"):
		anim_player.play("grow")
		

		


func _on_AnimatedSprite_animation_finished():
	anim_player.stop()
