extends TextureProgressBar

func _ready():
	# Initialize the bar with current sanity
	value = GameManager.sanity

func _process(_delta):
	# Option 1: Instant response
	value = GameManager.sanity
	
	# Option 2: Smooth "Draining" effect
	# This makes the bar slide slowly rather than snapping
	value = lerp(value, GameManager.sanity, 0.1)
