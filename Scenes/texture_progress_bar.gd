extends TextureProgressBar

func _process(_delta):
	# Instant value update
	value = GameManager.sanity
	
	# Convert 100-0 sanity into 0.0-1.0 insanity
	var insanity_val = (100.0 - GameManager.sanity) / 100.0
	
	# Update the shader intensity
	if material is ShaderMaterial:
		material.set_shader_parameter("insanity", insanity_val)
