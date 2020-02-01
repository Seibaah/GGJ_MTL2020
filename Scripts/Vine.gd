extends KinematicBody2D

onready var anim_player = $AnimatedSprite

func _physics_process(delta):
	#plant_seed
	if Input.is_action_just_pressed("plant_seed"):
		anim_player.play("growing")
	if Input.is_action_just_released("plant_seed"):
		anim_player.stop()
	

		
		
