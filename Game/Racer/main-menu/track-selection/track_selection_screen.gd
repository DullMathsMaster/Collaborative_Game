extends Control


@onready var track_selection_box = $VBoxContainer/HBoxContainer


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
	UiLoader.load_into_men_space(GlobalData.game_track_path)
