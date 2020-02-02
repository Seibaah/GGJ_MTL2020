extends Node2D

const vineScene = preload("res://Vine.tscn")


#TODO
#connect to node asking growth to call _on_growth request



func _ready():
	$AnimationPlayer.play("effervescence")

func grow_plant(vine_rotation):#orientation is an int 
	var vineInstance = vineScene.instance()
	vineInstance.transform(rotate(vine_rotation))
	self.add_child(vineInstance)
	$Sprite.hide()
	$AnimationPlayer.stop()
