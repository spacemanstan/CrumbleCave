extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const ROTATION_SPEED = 3  # Adjust this value to control the rotation speed

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump using custom "jump" action.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement in world coordinates.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# Set the velocity based on the input direction in world space
	velocity.x = input_dir.x * SPEED
	velocity.z = input_dir.y * SPEED

	# Handle rotation
	var rotation_amount = 0.0
	if Input.is_action_pressed("ui_rotate_right"):
		rotation_amount -= ROTATION_SPEED
	if Input.is_action_pressed("ui_rotate_left"):
		rotation_amount += ROTATION_SPEED

	if rotation_amount != 0:
		rotate_y(rotation_amount * delta)

	move_and_slide()
