extends Control

@onready var object_container: HBoxContainer = %ObjectContainer
@onready var scroll_container: ScrollContainer = %ScrollContainer


var target_scroll = 0


func _ready() -> void:
	_set_selection()


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
	var selected_node = get_selected_value()
	
	for object in object_container.get_children():
		if object is not TextureRect: continue
		if object == selected_node: object.modulate = Color(1,1,1)
		else: object.modulate = Color(0,0,0)


func get_selected_value():
	var selected_position = %"Selection-Marker".global_position
	
	for object in object_container.get_children():
		if object.get_global_rect().has_point(selected_position):
			return object
