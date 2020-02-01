extends Node#placeholder

const WALK_SPEED = 250

var linear_vel = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	
	### CONTROL ###

	# Horizontal movement
	var target_speed = 0
	if Input.is_action_pressed("move_left"):
		target_speed -= 1
	if Input.is_action_pressed("move_right"):
		target_speed += 1

	target_speed *= WALK_SPEED
	
	#jump
	if Input.is_action_just_pressed("jump"):
		pass
	
	#plant_seed
	if Input.is_action_just_pressed("plant_seed"):
		pass
