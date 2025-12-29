extends Node3D

@export var tree_scene: PackedScene
@export var rock_scene: PackedScene
@export var spawn_count: int = 140
@export var map_size: int = 100 # Total width/length of your floor

func _ready():
	spawn_random_props()

func spawn_random_props():
	for i in range(spawn_count):
		# Randomly pick between tree or rock
		var prop_to_spawn = tree_scene if randf() > 0.5 else rock_scene
		var instance = prop_to_spawn.instantiate()
		
		# Pick a random position on the floor
		var x_pos = randf_range(-map_size/2, map_size/2)
		var z_pos = randf_range(-map_size/2, map_size/2)
		
		instance.position = Vector3(x_pos, 0, z_pos)
		add_child(instance)
