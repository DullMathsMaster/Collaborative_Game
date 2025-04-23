extends CharacterBody3D

# Define some constants
const MAX_SPEED = 100
const JUMP_VELOCITY = 100
const SENSITIVITY = 0.05
const ACCELERATION = 2
const GRAVITY = 20
const DECELERATION = 2

# Set the cube velocity to 0 initially
var current_velocity = 0
var start_position: Vector3

# Shortcuts to the camera and map point
@onready var camera = $Camera3D
@onready var point = get_node("../CanvasLayer/Map/ColorRect")


# For the movements of the actual car
func _physics_process(delta):
	# Create a vector to be edited for movement
	var input_vector = Vector3.ZERO

	# Turning left and rigjt
	input_vector.z -= 1
	if Input.is_action_pressed("ui_right"):
		rotate_y(-1 * SENSITIVITY)
	if Input.is_action_pressed("ui_left"):
		rotate_y(1 * SENSITIVITY)

	# Acceleration and deceleration
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
	
	# Keep the same movement with  respect to the way the car is facing
	input_vector = (transform.basis * input_vector).normalized()
	velocity = input_vector * current_velocity

	# Gravity
	if not is_on_floor():
		velocity.y -= GRAVITY
	else:
		velocity.y = 0
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_VELOCITY
	
	# Chenge the point position on the map
	var map_pos = Vector2.ZERO  
	var cube_pos = global_transform.origin
	map_pos.y = (cube_pos.z + 225) / 2.25 - 5
	map_pos.x = (cube_pos.x + 225) / 2.25 - 5
	point.position = map_pos
	
	# Move the car
	move_and_slide()
	
	if global_transform.origin.y < -20:
		var tf = global_transform
		tf.origin = start_position
		global_transform = tf
		current_velocity = 0
		velocity = Vector3.ZERO
