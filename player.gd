extends CharacterBody3D

signal PlayerDied
signal CollidedWithGem(body : Node)

@onready var animation_tree : AnimationTree = $AnimationTree

@export var Lava : Node3D

@export var SPEED = 5.0
@export var JUMP_VELOCITY = 4.5
@export var ROTATION_SPEED = 2  # Adjust this value to control the rotation speed
const LERP_VAL = 0.15

var camera: Camera3D
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	camera = $Camera3D  # Adjust this path according to your node hierarchy
	animation_tree.active # ensure animation tree is active on scene start 

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump using custom "jump" action.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = -(transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	
	if direction:
		velocity.x = lerp(velocity.x, direction.x * SPEED, LERP_VAL)
		velocity.z = lerp(velocity.z, direction.z * SPEED, LERP_VAL)
	else:
		velocity.x = lerp(velocity.x, direction.x * 0.0, LERP_VAL)
		velocity.z = lerp(velocity.z, direction.z * 0.0, LERP_VAL)
		
	# Handle rotation
	var rotation_amount = 0.0
	if Input.is_action_pressed("ui_rotate_right"):
		rotation_amount -= ROTATION_SPEED
	if Input.is_action_pressed("ui_rotate_left"):
		rotation_amount += ROTATION_SPEED

	if rotation_amount != 0:
		rotate_y(rotation_amount * delta)

	var shit = Vector2(velocity.length() / SPEED, velocity.y / JUMP_VELOCITY)
	animation_tree.set("parameters/BlendSpace2D/blend_position", shit)

	move_and_slide()
	
	if(position.y <= Lava.position.y):
		killPlayer()

func killPlayer():
	print("THE PLAYER IS DEAD")	
	respawnPlayer()
	PlayerDied.emit()

func respawnPlayer():
	# return the player to the starting spot
	position = Vector3(0,5,0)
	
func _on_world_game_start():
	respawnPlayer()


func _on_area_3d_body_entered(body):
	CollidedWithGem.emit(body)
