extends Node2D
var player_scene = preload("res://Player.tscn")
var world_scenes_array = ["World", "World-2"]

var current_player = null
var current_world_id = 0
var current_world = null
var selected_seed = null

# Called when the node enters the scene tree for the first time.
func _ready():
	load_level(1, Vector2(50,-50))

func _process(delta):
	#global inputs
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().reload_current_scene()
	
	#world stuff
	update_targeted_seed()

func load_level(level_id, player_start_pos):
	#Load the level
	var new_world_scene = load("res://" + world_scenes_array[level_id] + ".tscn")
	var new_world = new_world_scene.instance()
	self.add_child(new_world)
	
	#Load the player
	var new_player = player_scene.instance()
	self.global_position.x = player_start_pos.x
	self.global_position.y = player_start_pos.y
	self.add_child(new_player)
	#Connect the players
	if new_player != null:
		new_player.connect("has_planted", self, "_on_player_planting")
		current_player = new_player
	
	
	#Connect seeds to have them push players
	var seeds = get_tree().get_nodes_in_group("PlantSeed")
	for a_seed in seeds:
		a_seed.connect("has_pushed_player")


### WORLD FUNCTIONS ###

func update_targeted_seed():
	#target the closest seed to the player
	if current_player == null:
		return
	var seeds = get_tree().get_nodes_in_group("seed")
	var min_distance = 20000
	var closest_distance = min_distance
	var new_seed_target = null
	for a_seed in seeds:
		var diff_distance_vector = current_player.global_position - a_seed.global_position
		var a_distance = diff_distance_vector.length()
		if a_distance < min_distance:
			if new_seed_target == null:
				closest_distance = a_distance
				new_seed_target = a_seed
			else:
				if a_distance < closest_distance:
					closest_distance = a_distance
					new_seed_target = a_seed
	
	if new_seed_target != selected_seed:
		var previous_selected_seed = selected_seed
		if selected_seed != null:
			previous_selected_seed.hide_as_target()
		selected_seed = new_seed_target
		selected_seed.display_as_target()

### SIGNALS ###

func _on_player_planting(player, orientation):
	#find the closest node to the player, and seed it
	if selected_seed != null:
		selected_seed.grow_plant(orientation)
