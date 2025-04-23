extends VehicleBody3D

# === Car Control Constants ===
const MAX_STEER = 1.2
const ENGINE_POWER = 500
var wheels = {}
var drift_spin_speed = 1
const MOVEMENT_THRESHOLD = 1.0

# === Optional UI / Map / Camera Tracking ===
@onready var camera = $Camera3D
@onready var point = get_node("../CanvasLayer/Map/ColorRect")
var start_position: Vector3

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	center_of_mass = Vector3(0, -0.5, 0)
	start_position = global_transform.origin

func _physics_process(delta):
	# Steering & Engine Force
	var steer_input = Input.get_axis("ui_right", "ui_left")
	steering = move_toward(steering, steer_input * MAX_STEER, delta * 100.0)
	engine_force = Input.get_axis("ui_down", "ui_up") * ENGINE_POWER

	# Drift & Turn Logic
	var is_drift_pressed = Input.is_action_pressed("drift")
	var turning = abs(steering) > 0.05
	var drifting = is_drift_pressed
	var forward = global_transform.basis.z.normalized()
	var movement_direction = forward.dot(linear_velocity)
	var moving = abs(movement_direction) > MOVEMENT_THRESHOLD
	set_drift_mode(drifting)

	angular_damp = 0.1 if turning else 3.0
	if turning and moving:
		apply_drift_spin(delta, movement_direction)

	# Map tracking
	var map_pos = Vector2.ZERO
	var car_pos = global_transform.origin
	map_pos.y = (car_pos.z + 225) / 2.25 - 5
	map_pos.x = (car_pos.x + 225) / 2.25 - 5
	point.position = map_pos

	# Reset if car falls
	if global_transform.origin.y < -20:
		var tf = global_transform
		tf.origin = start_position
		global_transform = tf
		linear_velocity = Vector3.ZERO
		angular_velocity = Vector3.ZERO


func set_drift_mode(enabled):
	for child in get_children():
		if child is VehicleWheel3D:
			match child.name:
				"rear_left", "rear_right":
					child.wheel_friction_slip = 0.8 if enabled else 7
				"front_left", "front_right":
					child.wheel_friction_slip = 1 if enabled else 1.0

func apply_drift_spin(delta, movement_direction):
	var spin_direction = sign(steering)
	if movement_direction < 0:
		spin_direction = -spin_direction
	angular_velocity.y = lerp(angular_velocity.y, drift_spin_speed * spin_direction, delta * 10)
	angular_velocity = angular_velocity
