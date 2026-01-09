extends CharacterBody3D
@onready var camera = $Player/Camera3D
@export var mouse_sensitivity = 0.002
const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var kills = 0
@onready var kill_count_label: Label = $"../CanvasLayer/KillCountLabel"


# Ensure your Camera3D path is correct

# Update this path to your rifle node
@onready var rifle = $moi/Armature_Monk/Skeleton3D/repeater

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# FIX 1: Negative input_dir.y makes "Up" move Forward (-Z)
	var direction := (transform.basis * Vector3(-input_dir.x, 0, -input_dir.y)).normalized()	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		# This rotates the whole player left/right
		rotate_y(-event.relative.x * mouse_sensitivity)
		
		# This rotates ONLY the camera up/down
		# We use .rotate_x because vertical looking is rotation around the X axis
		if has_node("Camera3D"):
			$Camera3D.rotate_x(event.relative.y * mouse_sensitivity)
			# Clamp prevents the camera from flipping over
			$Camera3D.rotation.x = clamp($Camera3D.rotation.x, deg_to_rad(-80), deg_to_rad(80))
		
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	# Trigger the shooting logic we set up earlier
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if rifle:
			rifle.shoot()
			
func add_kill():
	kills += 1
	if kill_count_label:
		kill_count_label.text = "Kills: " + str(kills)

		
func _ready():
	kill_count_label.text = "Kills: "
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
