extends Control

@onready var close_but = get_node("/root/Second-track/CanvasLayer/UI/NavBar/Button") 
@onready var car = get_node("/root/Second-track/CanvasLayer/MenuSpace/SubViewportContainer2/SubViewport/Player")

func _on_start_button_pressed() -> void:
	
	## Make the game run, time start and clear the screen
	#UiLoader.running = true
	#UiLoader.elapsed = Time.get_ticks_msec()
	#UiLoader.load_into_men_space("null")
	#close_but.visible = false
	#
	## Transport the player to the start position
	#var in_vec = [-4.524, -0.364, 24.857]
	#car.global_transform.origin = Vector3(in_vec[0], in_vec[1], in_vec[2])

	# Hello Rory, the line below is your code, but I just wanted to make the start button work for now
	UiLoader.load_into_men_space("res://main-menu/player-selection/player_selection.tscn")


func _on_controls_button_pressed() -> void:
	UiLoader.load_into_men_space("res://main-menu/controls/control.tscn")


func _on_credits_button_pressed() -> void:
	UiLoader.load_into_men_space("res://main-menu/credits/credits.tscn")
