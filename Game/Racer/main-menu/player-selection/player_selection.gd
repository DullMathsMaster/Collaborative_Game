extends Control



func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		UiLoader.load_into_men_space("res://main-menu/title-screen/title_screen.tscn")


func _on_single_player_button_pressed() -> void:
	GlobalData.two_player = false
	UiLoader.load_into_men_space("res://main-menu/racer-selection/racer_selection.tscn")


func _on_multi_player_button_pressed() -> void:
	GlobalData.two_player = true
	UiLoader.load_into_men_space("res://main-menu/racer-selection/racer_selection.tscn")
