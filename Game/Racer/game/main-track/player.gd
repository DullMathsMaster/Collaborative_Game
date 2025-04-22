extends CharacterBody3D

const MAX_SPEED = 100
const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.05
const ACCELERATION = 2
const GRAVITY = 20
const DECELERATION = 2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var current_velocity = 0

# shortcuts to the child nodes
@onready var camera = $Camera3D

func _physics_process(delta):
	var input_vector = Vector3.ZERO
	var is_colliding = false
	
	#Turning left and rigjt
	input_vector.z -= 1
	if Input.is_action_pressed("ui_right"):
		rotate_y(-1 * SENSITIVITY)
	if Input.is_action_pressed("ui_left"):
		rotate_y(1 * SENSITIVITY)

	#Acceleration and deceleration
			
	if Input.is_action_pressed("ui_up"):
		if current_velocity < MAX_SPEED:
			current_velocity += ACCELERATION
	elif Input.is_action_pressed("ui_down"):
		if current_velocity > -MAX_SPEED:
			current_velocity -= ACCELERATION
	else:
		if current_velocity > 0:
			current_velocity -= DECELERATION
		elif current_velocity < 0:
			current_velocity += DECELERATION

	input_vector = (transform.basis * input_vector).normalized()
	velocity = input_vector * current_velocity

	#Gravity
	if not is_on_floor():
		velocity.y -= GRAVITY
	else:
		velocity.y = 0
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_VELOCITY

	move_and_slide()
	
