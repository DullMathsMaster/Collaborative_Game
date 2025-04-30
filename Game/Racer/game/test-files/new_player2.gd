extends CharacterBody3D

@export_group("Camera")
@export_range(0.0, 1.0) var mouse_sensitivity := 3.0

@export_group("Movement")
@export var move_speed := 20.0
@export var acceleration := 20.0
@export var handling := 12.0

var _camera_input_direction := Vector2.ZERO
var _last_movement_direction := Vector3.BACK
var _gravity := -30.0

@onready var _camera_pivot: Node3D = %CameraPivot2
@onready var _camera: Camera3D = %Camera3D2
@onready var _skin: MeshInstance3D = %Sedan2
@onready var _hitbox: CollisionShape3D = %Hitbox2
@onready var point = get_node("../../../../Map/ColorRect2")


#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("left_click"):
		#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	#if event.is_action_pressed("ui_cancel"):
		#Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
#
#
#func _unhandled_input(event: InputEvent) -> void:
	#var is_camera_motion := (
		#event is InputEventJoypadMotion# and
		#Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	#)
	#if is_camera_motion:
		#_camera_input_direction = Input.get_vector("camera_left", "camera_right", "camera_up", "camera_down") * mouse_sensitivity
		
		
func _physics_process(delta: float) -> void:
	_camera_pivot.rotation.x += Input.get_axis("camera_up", "camera_down") * delta * mouse_sensitivity
	_camera_pivot.rotation.x = clamp(_camera_pivot.rotation.x, -PI / 6.0, PI / 3.0)
	_camera_pivot.rotation.y -= Input.get_axis("camera_left", "camera_right") * delta * mouse_sensitivity
	
	_camera_input_direction = Vector2.ZERO
	
	var raw_input := Input.get_vector("move_left_2", "move_right_2", "move_forward_2", "move_backward_2")
	var forward := _camera.global_basis.z
	var right := _camera.global_basis.x
	
	var move_direction := forward * raw_input.y + right * raw_input.x
	move_direction.y = 0.0
	move_direction = move_direction.normalized()

	var y_velocity := velocity.y
	velocity.y = 0.0
	velocity = velocity.move_toward(move_direction * move_speed, acceleration * delta)
	velocity.y = y_velocity + _gravity * delta
	
	# Change the point position on the map
	var map_pos = Vector2.ZERO  
	var cube_pos = global_transform.origin
	map_pos.y = (cube_pos.z + 75) / (0.75) - 5
	map_pos.x = (cube_pos.x + 75) / (0.75) - 5
	point.position = map_pos
	
	move_and_slide()
	
	if move_direction.length() > 0.2:
		_last_movement_direction = move_direction
		
	var target_angle := Vector3.BACK.signed_angle_to(_last_movement_direction, Vector3.UP)
	_skin.global_rotation.y = lerp_angle(_skin.rotation.y, target_angle, handling * delta)
	_hitbox.global_rotation.y = lerp_angle(_hitbox.rotation.y, target_angle, handling * delta)


func _on_control_gui_input(event: InputEvent) -> void:
	pass # Replace with function body.
