extends Control


func _on_start_button_pressed() -> void:
	
	# Hey rory, I am just gonna change these to fit inside the panel I have in the 3d game
	UiLoader.load_into_men_space("res://main-menu/player-selection/player_selection.tscn")


func _on_controls_button_pressed() -> void:
	UiLoader.load_into_men_space("res://main-menu/controls/control.tscn")


func _on_credits_button_pressed() -> void:
	UiLoader.load_into_men_space("res://main-menu/credits/credits.tscn")
