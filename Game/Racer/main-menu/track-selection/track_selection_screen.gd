extends Control


@onready var track_selection_box = $Panel/VBoxContainer/HBoxContainer
@onready var close_but = get_node("/root/Second-track/CanvasLayer/UI/NavBar/Button") 
@onready var car = get_node("/root/Second-track/CanvasLayer/MenuSpace/SubViewportContainer2/SubViewport/Player")


func _input(event):
	if event is InputEventMouseButton && event.button_index == 1 && event.is_pressed():
		var track_node = _get_track_node()
		
		if track_node: _set_track_selected(track_node)

func _get_track_node():
	var mouse_pos = get_viewport().get_mouse_position()
	for node in track_selection_box.get_children():
		if node.get_global_rect().has_point(mouse_pos):
			return node

func _set_track_selected(track_node):
	GlobalData.game_track_path = track_node.track_path
	
	for node in track_selection_box.get_children():
		var is_selected = track_node == node
		node.set_selected(is_selected)

func _on_start_button_pressed() -> void:
	if not GlobalData.game_track_path:
		print("No track selected")
		return
	# Make the game run, time start and clear the screen
	UiLoader.running = true
	UiLoader.elapsed = Time.get_ticks_msec()
	UiLoader.load_into_men_space("null")
	close_but.visible = false
	
	# Transport the player to the start position
	var in_vec = [-4.524, -0.364, 24.857]
	car.global_transform.origin = Vector3(in_vec[0], in_vec[1], in_vec[2])
	#UiLoader.load_into_men_space(GlobalData.game_track_path)
