#World_complete.gd
extends Area2D

signal ask_next_level

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("player"):
			print("emmitttt")
			emit_signal("ask_next_level")
			#get_tree().change_scene("World-2.tscn")
