extends Node3D

@export var enemy_scene: PackedScene
@export var spawn_timer: Timer

func spawn_cultist():
	var player = get_tree().get_first_node_in_group("Player")
	if player:
		var enemy = enemy_scene.instantiate()
		var random_direction = Vector3(randf_range(-1, 1), 0, randf_range(-1, 1)).normalized()
		
		# This calculates the position relative to the PLAYER'S current spot
		var spawn_pos = player.global_position + (random_direction * randf_range(15.0, 25.0))
		
		enemy.position = spawn_pos
		# It's better to add them to the main scene root so they don't move 
		# IF the spawner moves
		get_tree().current_scene.add_child(enemy)


func _on_timer_timeout() -> void:
	var max_enemies = 3 * GameManager.difficulty_modifier
	
	# Only spawn if we haven't reached the cap
	if get_child_count() < max_enemies:
		spawn_cultist()
