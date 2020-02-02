extends Node2D

#connect to node asking 

func _ready():
	$AnimationPlayer.play("effervescence")

func _on_growth_request():
	
