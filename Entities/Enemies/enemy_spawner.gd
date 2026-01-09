extends Node3D

@export var enemy_scene: PackedScene
@export var spawn_timer: Timer

func spawn_cultist():
	var player = get_tree().get_first_node_in_group("Player")
	if player:
		var enemy = enemy_scene.instantiate()
		var random_direction = Vector3(randf_range(-1, 1), 0, randf_range(-1, 1)).normalized()
		
		# Set the position
		var spawn_pos = player.global_position + (random_direction * randf_range(15.0, 25.0))
		enemy.global_position = spawn_pos
		
		# CHANGE THIS LINE: Remove the 'get_tree().current_scene' part
		# Just use add_child(enemy). This puts the enemy INSIDE the spawner.
		add_child(enemy)


func _on_timer_timeout() -> void:
	var max_enemies = 3 * GameManager.difficulty_modifier
	
	# Only spawn if we haven't reached the cap
	if get_child_count() < max_enemies:
		spawn_cultist()
