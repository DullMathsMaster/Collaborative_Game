extends Node3D

# define constants for accessing checkpoint and red dot in map
@onready var checkpoint = $CanvasLayer/MenuSpace/SubViewportContainer/SubViewport/Checkpoint

# These are the teleport coordinates and their corresponding rotations for the checkpoint to be in place
const cp_pts = [
	[
		[-29.71, 1.6667, 36.314],
		[0.0, 1.6667, 22.3333],
		[25.846, 1.6667, 10.204],
		[37.041, 1.6667, -13.629],
		[37.041, 1.6667, -37.6177],
		[19.997, 1.6667, -45.2333],
		[3.2663, 1.6667, -29.7],
		[-15.958, 1.6667, -24.6133],
		[-30.93, 1.6667, -30.5967],
		[-39.226, 1.6667, -6.5267],
		[-39.226, 1.6667, 26.6563]
	],
	[
		[0.0, 25.0, 0.0],
		[0.0, 25.0, 0.0],
		[0.0, 25.0, 0.0],
		[0.0, 90.0, 0.0],
		[0.0, 90.0, 0.0],
		[0.0, 0.0, 0.0],
		[0.0, 58.8, 0.0],
		[0.0, -20.2, 0.0],
		[0.0, -20.2, 0.0],
		[0.0, 90.0, 0.0],
		[0.0, 90.0, 0.0]
	]
]
# Define num of teleports
const cp_pts_lgth = len(cp_pts[0])

# The player starts at position 0
var player_pos = 0


# This is for moving the checkpoint and updating when the player passes through it
func _on_checkpoint_area_exited(area: Area3D) -> void:
	var player = area.get_parent()
	if player.name == "Player":
		player_pos += 1
		var in_vec = cp_pts[0][player_pos % cp_pts_lgth]
		var in_rot = cp_pts[1][player_pos % cp_pts_lgth]
		checkpoint.global_transform.origin = Vector3(in_vec[0], in_vec[1], in_vec[2])
		checkpoint.rotation = Vector3(deg_to_rad(in_rot[0]), deg_to_rad(in_rot[1]), deg_to_rad(in_rot[2]))
