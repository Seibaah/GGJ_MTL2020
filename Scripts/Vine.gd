extends KinematicBody2D


onready var anim_player = $AnimationPlayer

func _ready():
	anim_player.play("grow")


func _on_AnimatedSprite_animation_finished():
	anim_player.stop()
	print("test")
