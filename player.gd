extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const ROTATION_SPEED = 2  # Adjust this value to control the rotation speed

var camera: Camera3D
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	camera = $Camera3D  # Adjust this path according to your node hierarchy

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump using custom "jump" action.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction.
	var input_dir = Vector3(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"), 
							0,
							Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")).normalized()  # Normalize the input vector

	# Make movement direction relative to the camera's global orientation
	input_dir = camera.global_transform.basis * input_dir

	# Apply the speed factor to horizontal components
	velocity.x = input_dir.x * SPEED
	velocity.z = input_dir.z * SPEED

	# Handle rotation
	var rotation_amount = 0.0
	if Input.is_action_pressed("ui_rotate_right"):
		rotation_amount -= ROTATION_SPEED
	if Input.is_action_pressed("ui_rotate_left"):
		rotation_amount += ROTATION_SPEED

	if rotation_amount != 0:
		rotate_y(rotation_amount * delta)

	move_and_slide()
