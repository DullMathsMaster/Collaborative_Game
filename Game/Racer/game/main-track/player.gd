extends VehicleBody3D

const MAX_STEER = 1.2
const ENGINE_POWER = 500
var wheels = {}
var drift_spin_speed = 1
const MOVEMENT_THRESHOLD = 1.0


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	center_of_mass = Vector3(0, -1.2, 0)

func _physics_process(delta):
	var steer_input = Input.get_axis("ui_right", "ui_left")
	steering = move_toward(steering, steer_input * MAX_STEER, delta * 100.0)
	engine_force = Input.get_axis("ui_down", "ui_up") * ENGINE_POWER
	
	var is_drift_pressed = Input.is_action_pressed("drift")
	var turning = abs(steering) > 0.05
	var drifting = is_drift_pressed
	var forward = global_transform.basis.z.normalized()
	var movement_direction = forward.dot(linear_velocity)
	var moving = abs(movement_direction) > MOVEMENT_THRESHOLD
	set_drift_mode(drifting)
	
	var speed = linear_velocity.length()
	
	set_drift_mode(drifting)
	
	angular_damp = 0.1 if turning else 3.0
	
	if turning and moving:  
		apply_drift_spin(delta,movement_direction)


func set_drift_mode(enabled):
	for child in get_children():
		if child is VehicleWheel3D:
			match child.name:
				"rear_left", "rear_right":
					child.wheel_friction_slip = 0.8 if enabled else 7


func apply_drift_spin(delta,movement_direction):
	var velocity = linear_velocity
	var forward = global_transform.basis.z.normalized()  # Car's forward direction
	var side_force = forward.cross(Vector3.UP).normalized()
	
	var spin_direction = sign(steering)  # Drift should swing opposite to steering
	
	
	# Apply opposite rotation when moving backward	
	if movement_direction < 0:
		spin_direction = -spin_direction
	
	angular_velocity.y += drift_spin_speed * spin_direction * delta
	angular_velocity = angular_velocity
