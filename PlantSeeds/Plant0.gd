extends KinematicBody2D

var is_planted:bool = false
var is_withered:bool = false
var has_pushed_timer:bool = false

var is_growing:bool = false
export var plant_id:int = 0
export var direction_growth:Vector2 = Vector2(0,0)
export var impact_force = 50

const HAS_GROWN = "has_grown"
const HAS_WITHERED = "has_withered"
const HAS_PUSHED_PLAYER = "has_pushed_player"
signal has_grown
signal has_withered
signal has_pushed_player


func _physics_process(delta):
	if !has_pushed_timer:
		if is_growing:
			var bodies = $Area2D.get_overlapping_bodies()
			for a_body in bodies:
				if a_body.is_in_group("player"):
					var pushed_player = a_body
					has_pushed_timer = true
					$Timer.start()
					emit_signal("has_pushed_player", self, pushed_player)

func shrug():
	pass

func wither():
	self.hide()
	is_growing = false

func grow():
	self.show()
	is_growing = true

func stop_growing():
	is_growing = true


func _on_Timer_timeout():
	has_pushed_timer = false
	$Timer.stop()
