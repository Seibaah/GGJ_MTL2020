extends "res://MainGame.gd"

<<<<<<< HEAD
func _ready():
	$Music.stop()
=======

func _ready():
>>>>>>> cce65eea84f38cce97d604e5944f195aa6a56561
	$Music.play()

func _process(delta):
	var time = $Music.get_playback_position() + AudioServer.get_time_since_last_mix() - AudioServer.get_output_latency()
	# Compensate for output latency.
	time -= AudioServer.get_output_latency()
<<<<<<< HEAD
=======
	print("Time is: ", time)
>>>>>>> cce65eea84f38cce97d604e5944f195aa6a56561
