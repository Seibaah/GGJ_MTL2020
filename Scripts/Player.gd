extends KinematicBody2D

#Physics' variables
const UP = Vector2(0, -1)
const GRAVITY = 20
const MAX_CONTROL_SPEED = 200
const MAX_BOUNCE_SPEED = 400
const JUMP_FORCE = 800
const ACCELERATION = 50
const MAX_FALL_SPEED = 1000

var motion = Vector2()

signal has_planted
signal has_planted_left
signal has_planted_right
signal has_planted_up
signal has_planted_down

#Animation variables
#onready var anim_player = $AnimationPlayer
onready var anim_player = $AnimationPlayer
onready var sprite = $Spirit
var facing_right = true

func _physics_process(_delta):
	motion.y += GRAVITY
	var friction = false
	
	if Input.is_action_pressed("move_right"):
		motion.x = min (motion.x + ACCELERATION, MAX_CONTROL_SPEED)
		play_anim("walk")
	elif Input.is_action_pressed("move_left"):
		motion.x = max (motion.x - ACCELERATION, -MAX_CONTROL_SPEED)
		play_anim("walk")
	else: 
		friction = true
		play_anim("walk")
		
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			motion.y = -JUMP_FORCE
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2)
	else:
		play_anim("walk")	
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.05)
		
	move_and_slide(Vector2(motion.x, motion.y), UP)
			
	if is_on_ceiling():
		motion.y = 0
	if is_on_floor() and motion.y >= 5:
		motion.y = 5
	if motion.y > MAX_FALL_SPEED:
		motion.y = MAX_FALL_SPEED
	
#	#Play correct sprite
#	if grounded:
#		if motion.x == 0:
#			play_anim("idle")
#		else:
#			play_anim("walk")
#	else:
		
		
	#flip sprite
	if facing_right and motion.x < 0:
		flip()
	if !facing_right and motion.x > 0:
		flip()
	
	#select_seed
	if Input.is_action_just_pressed("select_next_seed"):
		pass
	#plant_seed
	if !is_on_floor():
		if Input.is_action_just_pressed("plant_seed"):
			emit_signal("has_planted", self)
		
		if Input.is_action_just_pressed("plant_left_p0"):
			emit_signal("has_planted", self, "left")
		if Input.is_action_just_pressed("plant_right_p0"):
			emit_signal("has_planted", self, "right")
		if Input.is_action_just_pressed("plant_up_p0"):
			emit_signal("has_planted", self, "up")
		if Input.is_action_just_pressed("plant_left_p0"):
			emit_signal("has_planted", self, "down")
	
#function that applies a bounciness to a player's velocity vector
#push_direction is Vector2, push_force is Int
#F = nkx : n=contact normal, k=spring coeff, x=compression distance
#F = ma :  m=mass, a=acceleration
#
#NOT FINAL
#
func bounce(push_direction, push_force):
	var x = 16
	var mass = 16
	if push_direction.x != 0:
		if push_direction.x == 1:
			motion.x += push_force
		else: motion.x += push_force
	elif push_direction.y != 0:
		if push_direction.y ==-1:
			motion.y += push_force
		else: motion.x += push_force
	
		


#function to flip sprite
func flip():
	facing_right = !facing_right
	sprite.flip_h = !sprite.flip_h

#function to play sprite animation
func play_anim(anim_name):
	if anim_player.is_playing() and anim_player.current_animation == anim_name:
		return
	anim_player.play(anim_name)
	
#
#function to instance a placed platform - deprecated
#
#func place_platform():
#	#spwan a static tile underneath the player
#
#	var curr_pos = position
#	var plat = load("res://Platform.tscn")
#	var platform = plat.instance()
#	add_child_below_node(get_tree().get_root().get_node("TileMap"), platform)
	

		
		
