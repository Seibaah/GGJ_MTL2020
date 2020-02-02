extends Node2D

onready var button_highlight = $Continue
var t = Theme.new()

signal start_game

var current_screen = null

func _ready():
	register_buttons()
	#change_screen($TitleScreen)

func register_buttons():
	var buttons = get_tree().get_nodes_in_group("MenuOptions")
	for button in buttons:
		button.connect("pressed", self, "_on_button_pressed", [button.name])

func _on_button_pressed(name):
	match name:
		"Continue":
			change_screen($TitleScreen)
		"New Game":
			#change_screen(null)
			
			yield(get_tree().create_timer(0.5), "timeout")
			emit_signal("start_game")
			
		"Options":
			change_screen($SettingsScreen)

func change_screen(new_screen):
	if current_screen:
		current_screen.disappear()
		yield(current_screen.tween, "tween_completed")
	current_screen = new_screen
	if new_screen:
		current_screen.appear()
		yield(current_screen.tween, "tween_completed")

func game_over():
	change_screen($GameOverScreen)


func _on_New_Game_pressed():
	#var fadein = get_parent().get_parent().get_parent().get_parent().get_child(1)
	#fadein.visible = true
	#$AnimationPlayer.play("fade_in")
	get_tree().change_scene("res://MainGame.tscn")
