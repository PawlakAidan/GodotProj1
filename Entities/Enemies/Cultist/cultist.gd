extends CharacterBody3D

@export var base_speed = 3.0
# We use @onready to find the player once when the cultist spawns
@onready var player = get_tree().get_first_node_in_group("Player")

func _physics_process(_delta):
	# IMPORTANT: Check if the player exists and if GameManager is ready
	if player and GameManager:
		# 1. Point at the player
		var target_pos = player.global_position
		target_pos.y = global_position.y # This "levels" the gaze
		look_at(target_pos)
		
		var current_speed = base_speed * GameManager.difficulty_modifier
		
		# 3. Calculate direction
		var direction = (player.global_position - global_position).normalized()
		
		# 4. Apply velocity using the new dynamic speed
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	
	# Handle gravity
	if not is_on_floor():
		velocity.y -= 9.8 * _delta
		
	move_and_slide()
