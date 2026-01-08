extends Node3D

@export var bullet_scene : PackedScene # Check the Inspector for this slot!
@onready var muzzle = $Muzzle  # Must match the name in the tree exactly
@onready var flash = $Muzzle/MeshInstance3D

func shoot():
	# 1. Flash
	if flash:
		flash.visible = true
		await get_tree().create_timer(0.05).timeout
		flash.visible = false
	
	# 2. Bullet
	if bullet_scene:
		var new_bullet = bullet_scene.instantiate()
		get_tree().root.add_child(new_bullet)
		new_bullet.global_transform = muzzle.global_transform
