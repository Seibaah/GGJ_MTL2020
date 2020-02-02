extends Control


func _ready():
	pass # Replace with function body.


func _on_BtnStart_pressed():
	get_tree().change_scene("res://MainGame.tscn")

func _on_BtnCredits_pressed():
	$Credits.show()


func _on_BtnExit_pressed():
	get_tree().quit()

func _on_BtnCloseCredits_pressed():
	$Credits.hide()
