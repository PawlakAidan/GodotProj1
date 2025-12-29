extends CharacterBody3D

@export var speed = 3.0
@onready var player = get_tree().get_first_node_in_group("Player")

func _physics_process(_delta):
	if player:
		# 1. Point at the player
		look_at(player.global_position)
		
		# 2. Calculate direction
		var direction = (player.global_position - global_position).normalized()
		
		# 3. Move on the X and Z axes (don't fly!)
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	
	# Handle gravity (standard for CharacterBody3D)
	if not is_on_floor():
		velocity.y -= 9.8 * _delta
		
	move_and_slide()
