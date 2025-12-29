extends SpotLight3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# Randomly adjust energy slightly to create a subtle buzz/flicker
	if randf() > 0.95:
		light_energy = randf_range(1.0, 2.0)
