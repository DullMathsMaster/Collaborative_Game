extends Control


var racer_index = 0
var number_of_racers = len(GlobalData.car_paths)


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		# If player 1 has selected their car
		if GlobalData.two_player && GlobalData.player_one_car != -1:
			GlobalData.player_one_car = -1
			get_tree().change_scene_to_file("res://main-menu/racer-selection/racer_selection.tscn")
		# If player 1 has not selected their car
		else:
			get_tree().change_scene_to_file("res://main-menu/player-selection/player_selection.tscn")


func _on_confirm_button_pressed() -> void:
	# If player 1 of 2 has just selected their car
	if GlobalData.two_player && GlobalData.player_one_car == -1:
		GlobalData.player_one_car = racer_index
		get_tree().change_scene_to_file("res://main-menu/racer-selection/racer_selection.tscn")
	# If player 2 of 2 has just selected their car
	elif GlobalData.two_player:
		GlobalData.player_two_car = racer_index
		get_tree().change_scene_to_file("res://main-menu/track-selection/track_selection.tscn")
	# If player 1 of 1 has just selected car
	else:
		GlobalData.player_one_car = racer_index
		get_tree().change_scene_to_file("res://main-menu/track-selection/track_selection.tscn")


func _on_prev_racer_button_pressed() -> void:
	racer_index = (racer_index - 1) % number_of_racers


func _on_next_racer_button_pressed() -> void:
	racer_index = (racer_index + 1) % number_of_racers
