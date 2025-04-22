extends Control



func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://main-menu/title-screen/title_screen.tscn")


func _on_single_player_button_pressed() -> void:
	GlobalData.two_player = false
	get_tree().change_scene_to_file("res://main-menu/racer-selection/racer_selection.tscn")


func _on_multi_player_button_pressed() -> void:
	GlobalData.two_player = true
	get_tree().change_scene_to_file("res://main-menu/racer-selection/racer_selection.tscn")
