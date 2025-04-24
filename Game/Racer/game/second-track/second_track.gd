extends Node3D

# define constants for accessing checkpoint and red dot in map
@onready var checkpoint = $CanvasLayer/MenuSpace/SubViewportContainer/SubViewport/Checkpoint
@onready var close_but = $CanvasLayer/UI/NavBar/Button

@onready var leaderboard = "res://game/second-track/Leaderboard.txt"
var time = "00:00"
var current = 0
var write_back = ""
var label_write = ""
var file = ""
var text = ""
var scores = []

func _ready() -> void:
	UiLoader.load_into_men_space("C:/Users/banan/Downloads/Merge Wilson's/Collaborative_Game/Game/Racer/main-menu/winner/winner.tscn")
	close_but.visible = true
	
	file = FileAccess.open(leaderboard, FileAccess.READ)
	text = file.get_as_text().split("\n")
	print(text)
	
	for line in text:
		print(line)
		if line.strip_edges() == "":
			continue  
		line = line.strip_edges().split(" ")
		if line.size() == 2:
			scores.append([int(line[1]), line[0]])
			
	scores.sort()
	file.close()
	print(scores)
	for i in range(0, 5):	
		label_write += str(i + 1) + ": " + str(scores[i][1]) + "\n"

	$CanvasLayer/MenuSpace/Control/Top_Scores.text = label_write

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_data()
		
func save_data():
	print("helsdfjkhsjfkhfwgwrgeth")
	file = FileAccess.open(leaderboard, FileAccess.WRITE)
	for i in range(0, len(scores)):	
		text = scores[i]
		write_back += str(text[1]) + " " + str(text[0]) + "\n"
	file.store_line(write_back)
	file.close()
		
# These are the teleport coordinates and their corresponding rotations for the checkpoint to be in place
const cp_pts = [
	[
		[25.846, 1.6667, 10.204],
		[37.041, 1.6667, -13.629],
		[37.041, 1.6667, -37.6177],
		[19.997, 1.6667, -45.2333],
		[3.2663, 1.6667, -29.7],
		[-15.958, 1.6667, -24.6133],
		[-30.93, 1.6667, -30.5967],
		[-39.226, 1.6667, -6.5267],
		[-39.226, 1.6667, 26.6563],
		[-29.71, 1.6667, 36.314],
		[0.0, 1.6667, 22.3333]
	],
	[
		[0.0, 25.0, 0.0],
		[0.0, 90.0, 0.0],
		[0.0, 90.0, 0.0],
		[0.0, 0.0, 0.0],
		[0.0, 58.8, 0.0],
		[0.0, -20.2, 0.0],
		[0.0, -20.2, 0.0],
		[0.0, 90.0, 0.0],
		[0.0, 90.0, 0.0],
		[0.0, 25.0, 0.0],
		[0.0, 25.0, 0.0]
	]
]
# Define num of teleports
const cp_pts_lgth = len(cp_pts[0])

# The player starts at position 0
var player_pos = 0


# This is for moving the checkpoint and updating when the player passes through it
func _on_checkpoint_area_exited(area: Area3D) -> void:
	var player = area.get_parent()
	if player.name == "Player" and UiLoader.running:
		var in_vec = cp_pts[0][player_pos % cp_pts_lgth]
		var in_rot = cp_pts[1][player_pos % cp_pts_lgth]
		player_pos += 1
		if (player_pos - 1) / cp_pts_lgth >= 1:
			player_pos = 0
			UiLoader.running = false
			UiLoader.load_into_men_space("C:/Users/banan/Downloads/Merge Wilson's/Collaborative_Game/Game/Racer/main-menu/winner/winner.tscn")
			close_but.visible = true
			
			label_write = ""
			scores.append([int(str(current)), time])
			scores.sort()
			for i in range(0, 5):	
				label_write += str(i + 1) + ": " + str(scores[i][1]) + "\n"
		
			$CanvasLayer/MenuSpace/Control/Top_Scores.text = label_write
		else:
			checkpoint.global_transform.origin = Vector3(in_vec[0], in_vec[1], in_vec[2])
			checkpoint.rotation = Vector3(deg_to_rad(in_rot[0]), deg_to_rad(in_rot[1]), deg_to_rad(in_rot[2]))
		
			
			
			
			
func _process(delta: float) -> void:
	if UiLoader.running:
		current = round((Time.get_ticks_msec() - UiLoader.elapsed) / 1000)
		var secs =  (str(current % 60)).reverse() + "0"
		var mins =  (str(current / 60)).reverse() + "0"
		time[4] = secs[0]
		time[3] = secs[1]
		time[1] = mins[0]
		time[0] = mins[1]
		$CanvasLayer/Time.text = time
	
