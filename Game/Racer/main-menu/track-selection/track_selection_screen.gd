extends Control


@onready var close_but = get_node("/root/Second-track/CanvasLayer/UI/NavBar/Button") 
@onready var car_1 = $"Panel/VBoxContainer/HBoxContainer/Player-1/Player-1-Car"
@onready var car_2 = $"Panel/VBoxContainer/HBoxContainer/Player-2/Player-2-Car"


func _ready():
	car_1.texture = load(GlobalData.car_image_path_header + GlobalData.car_names[GlobalData.player_one_car] + GlobalData.car_image_file_type)
	if GlobalData.two_player:
		car_2.texture = load(GlobalData.car_image_path_header + GlobalData.car_names[GlobalData.player_two_car] + GlobalData.car_image_file_type)
	else:
		car_2.texture = null


func _on_start_button_pressed() -> void:
	# Make the game run, time start and clear the screen
	
	
	UiLoader.elapsed = Time.get_ticks_msec()
	UiLoader.load_into_men_space("null")
	close_but.visible = false
	
	var in_vec = [-4.524, -0.364, 24.857]
	
	UiLoader.load_into_men_space("clear all")
	
	# Transport the player to the start position
	if GlobalData.two_player:
		UiLoader.load_into_men_space("res://game/second-track/Player_1.tscn")
		UiLoader.load_into_men_space("res://game/second-track/Player_2.tscn")
		var player2 = get_node("/root/Second-track/CanvasLayer/MenuSpace/SubViewportContainer3/SubViewport/Player2/Sedan2")
		player2.mesh = load(GlobalData.car_path_header + GlobalData.car_names[GlobalData.player_two_car] + GlobalData.car_file_type)
		player2.get_parent().global_transform.origin = Vector3(in_vec[0], in_vec[1], in_vec[2] + 10.0)
		GlobalData.p2_finish = false
	else:
		UiLoader.load_into_men_space("res://game/second-track/Player_Main.tscn")
	
	var player1 = ""
	if GlobalData.two_player:
		player1 = get_node("/root/Second-track/CanvasLayer/MenuSpace/SubViewportContainer2/SubViewport/Player/Sedan")
	else:
		player1 = get_node("/root/Second-track/CanvasLayer/MenuSpace/SubViewportContainer/SubViewport/Player/Sedan")
	
	player1.mesh = load(GlobalData.car_path_header + GlobalData.car_names[GlobalData.player_one_car] + GlobalData.car_file_type)
	player1.get_parent().global_transform.origin = Vector3(in_vec[0], in_vec[1], in_vec[2])
	GlobalData.p1_finish = false

	UiLoader.running = true
	#UiLoader.load_into_men_space(GlobalData.game_track_path)
