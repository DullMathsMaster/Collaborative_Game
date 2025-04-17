extends Node3D

# define some constants for changing checkpoints
@onready var checkpoint = $Checkpoint
const cp_pts = [[[0.0, 5.0, 67.0], [78.715, 5.0, 30.316]],
				[[0.0, 25.0, 0.0], [0.0, 25.0, 0.0]]]
const cp_pts_lgth = len(cp_pts)
var player_pos = 0
var flag = true

func _on_checkpoint_area_exited(area: Area3D) -> void:
	var player = area.get_parent()
	var in_vec = cp_pts[0][player_pos % cp_pts_lgth]
	var in_rot = cp_pts[1][player_pos % cp_pts_lgth]
	print("entered ", player_pos)
	if player.name == "Player" and flag:
		
		player_pos += 1
		checkpoint.global_transform.origin = Vector3(in_vec[0], in_vec[1], in_vec[2])
		checkpoint.rotation = Vector3(in_rot[0], in_rot[1], in_rot[2])
	if flag:
		flag = false
	else:
		flag = true
