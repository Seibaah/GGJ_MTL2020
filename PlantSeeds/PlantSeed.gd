extends KinematicBody2D

var available_plants = [0, 1]
var is_planted:bool = false
var is_withered:bool = false
var current_plant = null
var grown_plant = null

const VINE_RESOURCE = preload("res://Vine.tscn")
const HAS_GROWN = "has_grown"
const HAS_WITHERED = "has_withered"
signal has_grown
signal has_withered
signal has_pushed_player

func _ready():
	$AnimationPlayer.play("default")
	

#func _process(_delta):

#	### SHRUG IF THE PLAYER IS CLOSE
#	var bodies_close = $DetectionArea2D.get_overlapping_bodies()
#	for a_body in bodies_close:
#		if a_body.is_in_group("player"):
#			self.shrug()

func get_available_plants():
	return available_plants

func display_as_target():
	$TargetedSprite.show()
	if $SeedSprite.visible:
		if $AnimationPlayer.assigned_animation != "shrug":
			$AnimationPlayer.play("shrug")

func hide_as_target():
	$TargetedSprite.hide()
	if $SeedSprite.visible:
		if $AnimationPlayer.assigned_animation != "default":
			$AnimationPlayer.play("default")

#func shrug():
#	if $SeedSprite.visible:
#		if $AnimationPlayer.assigned_animation != "shrug":
#			$AnimationPlayer.play("shrug")
#	elif current_plant != null:
#		current_plant.shrug()

func grow_plant(ori):
	if  is_withered:
		pass
	else:
		
#		if available_plants.find(plant_id) == -1:
#			pass
#		else:
		if is_planted:
			wither()
		force_grow_plant(ori)

func force_grow_plant(ori):

	$SeedSprite.hide()
	grown_plant = VINE_RESOURCE.instance()
	grown_plant.rotate(ori)
	self.add_child(grown_plant)
#	var plants =  $Plants.get_children()
#	if is_planted:
#		for a_plant in plants:
#			if a_plant != target_plant:
#				a_plant.wither()

	current_plant = grown_plant
	is_planted = true
	
	emit_signal("has_grown", self)

func wither():
	if grown_plant != null:
		grown_plant.queue_free()
	

#old version of wither
#func wither():
#	$SeedSprite.hide()
#	var plants =  $Plants.get_children()
#	if is_planted:
#		for a_plant in plants:
#			a_plant.wither()
#		is_planted = false
#		is_withered = true
#		emit_signal("has_withered", self)


func wither_and_compost():
	wither()
	$SeedSprite.show()
	is_planted = false
	is_withered = false
	emit_signal("has_withered", self)
	
