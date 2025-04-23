extends Control


func _on_button_pressed() -> void:
	UiLoader.load_into_men_space("res://main-menu/title-screen/title_screen.tscn")


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		UiLoader.load_into_men_space("res://main-menu/title-screen/title_screen.tscn")
