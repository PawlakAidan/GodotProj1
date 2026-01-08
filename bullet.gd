extends Area3D

var speed = 50.0

func _process(delta):
	# Move the bullet forward along its own Z-axis
	position += transform.basis.z * speed * delta

# Optional: Delete bullet after 2 seconds so they don't lag the game
func _ready():
	await get_tree().create_timer(2.0).timeout
	queue_free()
