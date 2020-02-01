extends KinematicBody2D

onready var anim_player = $AnimatedSprite
var anim_playing = false

func _physics_process(delta):
	#plant_seed
	if Input.is_action_just_pressed("plant_seed"):
		anim_player.play("growing")
		anim_playing = anim_player.is_playing()
		#_on_AnimatedSprite_animation_finished()
	if Input.is_action_just_released("plant_seed"):
		if not anim_playing:
			anim_player.stop()
		


func _on_AnimatedSprite_animation_finished():
	anim_player.stop()
