extends Node3D

# define constants for accessing checkpoint and red dot in map
@onready var checkpoint = $Checkpoint

# These are the teleport coordinates and their corresponding rotations for the checkpoint to be in place
const cp_pts = [
	[
		[-89.129, 5.0, 108.942],
		[0.0, 5.0, 67.0],
		[77.537, 5.0, 30.612],
		[111.123, 5.0, -40.886],
		[111.123, 5.0, -112.853],
		[59.99, 5.0, -135.7],
		[9.799, 5.0, -89.1],
		[-47.874, 5.0, -73.84],
		[-92.79, 5.0, -91.79],
		[-117.678, 5.0, -19.58],
		[-117.678, 5.0, 79.969]
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
