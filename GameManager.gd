extends Node

# 100 = Sane, 0 = Total Madness
var sanity: float = 0.0
var difficulty_modifier: float = 1.0

func _process(_delta):
	# Calculate insanity (how much sanity is lost)
	var insanity = 100.0 - sanity
	
	# Difficulty climbs from 1.0x to 4.0x as you go crazy
	# We use 33.3 so it hits max difficulty at 0 sanity
	difficulty_modifier = clamp(1.0 + (insanity / 33.3), 1.0, 4.0)

func change_sanity(amount: float):
	sanity = clamp(sanity + amount, 0, 100)
