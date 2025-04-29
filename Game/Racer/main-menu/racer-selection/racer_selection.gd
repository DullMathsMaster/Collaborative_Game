extends Control

@onready var object_container: HBoxContainer = %ObjectContainer
@onready var scroll_container: ScrollContainer = %ScrollContainer
@onready var player_label: Label = $"PanelContainer/MarginContainer/VBoxContainer/Player-Label"


var target_scroll = 0


func _ready() -> void:
	if GlobalData.two_player and GlobalData.player_one_car != -1:
		player_label.text = "PLAYER 2"
	else:
		player_label.text = "PLAYER 1"
	_set_selection()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		# If player 1 has selected their car
		if GlobalData.two_player && GlobalData.player_one_car != -1:
			GlobalData.player_one_car = -1
			UiLoader.load_into_men_space("res://main-menu/racer-selection/racer_selection.tscn")
		# If player 1 has not selected their car
		else:
			UiLoader.load_into_men_space("res://main-menu/player-selection/racer_selection.tscn")


func _set_selection():
	await get_tree().create_timer(0.01).timeout
	_select_deselect_highlight()


func _on_previous_racer_button_pressed() -> void:
	var scroll_value = target_scroll - _get_space_between()
	await _tween_scroll(scroll_value)
	_select_deselect_highlight()


func _on_next_racer_button_pressed() -> void:
	var scroll_value = target_scroll + _get_space_between()
	await _tween_scroll(scroll_value)
	_select_deselect_highlight()


func _get_space_between():
	var distance_size = object_container.get_theme_constant("separation")
	var object_size = object_container.get_children()[1].size.x
	
	return distance_size + object_size


func _tween_scroll(scroll_value):
	target_scroll = scroll_value
	
	var tween = get_tree().create_tween()
	tween.tween_property(scroll_container, "scroll_horizontal", scroll_value, 0.25)
	await tween.finished


func _select_deselect_highlight():
	var selected_node = get_selected_value()[0]
	
	for object in object_container.get_children():
		if object is not TextureRect: continue
		if object == selected_node: object.modulate = Color(1,1,1)
		else: object.modulate = Color(0,0,0)


func get_selected_value():
	var selected_position = %"Selection-Marker".global_position
	var i = -1
	for object in object_container.get_children():
		if object.get_global_rect().has_point(selected_position):
			return [object, i]
		else: i = i + 1


func _on_racer_selection_button_pressed() -> void:
	var i = get_selected_value()[1]
	# If player 1 of 2 has just selected their car
	if GlobalData.two_player && GlobalData.player_one_car == -1:
		GlobalData.player_one_car = i
		UiLoader.load_into_men_space("res://main-menu/racer-selection/racer_selection.tscn")
	# If player 2 of 2 has just selected their car
	elif GlobalData.two_player:
		GlobalData.player_two_car = i
		UiLoader.load_into_men_space("res://main-menu/track-selection/track_selection.tscn")
	# If player 1 of 1 has just selected car
	else:
		GlobalData.player_one_car = i
		UiLoader.load_into_men_space("res://main-menu/track-selection/track_selection.tscn")
