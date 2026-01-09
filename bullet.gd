extends Area3D

var speed = 50.0 
var base_damage = 25

func _process(delta):
	# Flying forward
	position += transform.basis.z * speed * delta

func _on_area_entered(area):
	print("Bullet hit an AREA: ", area.name)
	if area.is_in_group("Head"):
		print("HEADSHOT detected!")
		var enemy = area.get_parent()
		if enemy.has_method("take_damage"):
			enemy.take_damage(base_damage * 2)
		queue_free()

func _on_body_entered(body):
	print("Bullet hit a BODY: ", body.name)
	if body.is_in_group("Enemy"):
		print("Body shot on ENEMY detected!")
		if body.has_method("take_damage"):
			body.take_damage(base_damage)
		queue_free()
