extends KinematicBody2D

#Physics' variables
const UP = Vector2(0, -1)
const GRAVITY = 20
const MAX_CONTROL_SPEED = 200
const MAX_BOUNCE_SPEED = 400
const JUMP_FORCE = 600
const ACCELERATION = 50
const MAX_FALL_SPEED = 1000
const DASH_SPEED = 750
const push_force_x = 600
const push_force_y = 350

var motion = Vector2()
var is_dashing = false

signal has_planted
signal has_planted_left
signal has_planted_right
signal has_planted_up
signal has_planted_down
signal has_died

#Animation variables
#onready var anim_player = $AnimationPlayer
onready var anim_player = $AnimationPlayer
onready var sprite = $Spirit
var facing_right = true

func _physics_process(_delta):
	motion.y += GRAVITY
	var friction = false
	
	var lethal_check_bodies = $LethalArea2D.get_overlapping_bodies()
	for a_body in lethal_check_bodies:
		if a_body.is_in_group("lethal"):
			die()
	var lethal_check_areas = $LethalArea2D.get_overlapping_areas()
	for a_body in lethal_check_areas:
		if a_body.is_in_group("lethal"):
			die()

	play_anim("walk")
	if !is_dashing:
		if Input.is_action_pressed("move_right"):
			motion.x = min (motion.x + ACCELERATION, MAX_CONTROL_SPEED)
		elif Input.is_action_pressed("move_left"):
			motion.x = max (motion.x - ACCELERATION, -MAX_CONTROL_SPEED)
		else: 
			friction = true

	
	if !is_on_floor():
		if Input.is_action_just_pressed("dash_right"):
			is_dashing = true
			$DashTimer.start()
			motion.x = DASH_SPEED
		elif Input.is_action_just_pressed("dash_left"):
			is_dashing = true
			$DashTimer.start()
			motion.x = -DASH_SPEED
	
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
#	if Input.is_action_just_pressed("select_next_seed"):
#		pass
	#plant_seed
#		if Input.is_action_just_pressed("plant_seed"):
#			emit_signal("has_planted", self)
	
	if Input.is_action_just_pressed("plant_left_p0"):
		emit_signal("has_planted", self, "left")
	if Input.is_action_just_pressed("plant_right_p0"):
		emit_signal("has_planted", self, "right")
	if Input.is_action_just_pressed("plant_up_p0"):
		emit_signal("has_planted", self, "up")
	if Input.is_action_just_pressed("plant_down_p0"):
		emit_signal("has_planted", self, "down")
	
#function that applies a bounciness to a player's velocity vector
#push_direction is Vector2, push_force is Int
#F = nkx : n=contact normal, k=spring coeff, x=compression distance
#F = ma :  m=mass, a=acceleration
#
#NOT FINAL
#
func bounce(push_direction:Vector2):
	var x = 16
	var mass = 16
	push_direction = push_direction.normalized()
	if abs(push_direction.x) > 0.3:
		if push_direction.x == 1:
			motion.x += push_force_x
		else: 
			motion.x -= push_force_x
	elif abs(push_direction.y) > 0.3:
		if push_direction.y ==-1:
			var prev_mot = motion.y
			motion.y = -1000
		else: 
			motion.y += push_force_y
	
		


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
	

func die():
	#$AnimationPlayer.play("die")
	self.emit_signal("has_died")


func _on_DashTimer_timeout():
	is_dashing = false
