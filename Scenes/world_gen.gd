extends Node3D

@export var tree_scene: PackedScene
@export var rock_scene: PackedScene
@export var grass_scene: PackedScene # New slot for your grass.glb

@export var spawn_count: int = 140
@export var map_size: int = 100 
@export var min_distance: float = 2.0 # Minimum meters between objects

var spawned_positions = []

func _ready():
	spawn_random_props()

func spawn_random_props():
	for i in range(spawn_count):
		var x_pos = randf_range(-map_size/2, map_size/2)
		var z_pos = randf_range(-map_size/2, map_size/2)
		var new_pos = Vector3(x_pos, 0, z_pos)
		
		# Check distance from player start (0,0,0) so you don't get stuck
		if new_pos.length() < 4.0:
			continue

		# Check if this position is too close to existing objects
		if is_position_safe(new_pos):
			spawn_prop(new_pos)

func is_position_safe(pos):
	for other_pos in spawned_positions:
		if pos.distance_to(other_pos) < min_distance:
			return false # Too close!
	return true # Safe to spawn

func spawn_prop(pos):
	# Random selection including grass
	var roll = randf()
	var prop_to_spawn
	
	if roll < 0.5:
		prop_to_spawn = tree_scene
	else:
		prop_to_spawn = rock_scene
		
	if prop_to_spawn:
		var instance = prop_to_spawn.instantiate()
		instance.position = pos
		# Randomly rotate the assets so they don't all face the same way
		instance.rotation.y = randf_range(0, TAU) 
		add_child(instance)
		spawned_positions.append(pos)
