extends Control


@onready var close_but = get_node("/root/Second-track/CanvasLayer/UI/NavBar/Button") 
@onready var car = get_node("/root/Second-track/CanvasLayer/MenuSpace/SubViewportContainer/SubViewportContainer/SubViewport/Player")
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
	UiLoader.running = true
	UiLoader.elapsed = Time.get_ticks_msec()
	UiLoader.load_into_men_space("null")
	close_but.visible = false
	
	# Transport the player to the start position
	var in_vec = [-4.524, -0.364, 24.857]
	car.global_transform.origin = Vector3(in_vec[0], in_vec[1], in_vec[2])
	#UiLoader.load_into_men_space(GlobalData.game_track_path)
