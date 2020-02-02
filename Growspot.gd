extends Node2D


onready var anim_player = $AnimationPlayer


func _physics_process(delta):
	#plant_seed
	#if Input.is_action_pressed("select_spot"):
		anim_player.play("anim")
		
func _on_AnimatedSprite_animation_finished():
	anim_player.stop()

