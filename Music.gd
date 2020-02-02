extends "res://MainGame.gd"


func _ready():
	$Music.play()

func _process(delta):
	var time = $Music.get_playback_position() + AudioServer.get_time_since_last_mix() - AudioServer.get_output_latency()
	# Compensate for output latency.
	time -= AudioServer.get_output_latency()
	print("Time is: ", time)
