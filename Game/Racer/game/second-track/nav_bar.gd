extends Panel
@onready var men_space = get_node("../../MenuSpace")
@onready var close_but = $Button
@onready var map =  get_node("../../Map")

var id_val = -1
var menu_instance: Control
var control_instance: Control

func _ready():
	close_but.visible = false
	map.visible = false
	
	var menu = $MenuButton.get_popup()
	menu.id_pressed.connect(_on_item_pressed)


func _on_item_pressed(id: int) -> void:
	id_val = id
	match id:
		0:
			UiLoader.load_into_men_space("res://main-menu/title-screen/title_screen.tscn")
		1:
			UiLoader.load_into_men_space("res://main-menu/controls/control.tscn")
	close_but.visible = true
		

func _on_button_pressed() -> void:
	UiLoader.load_into_men_space("null")
	close_but.visible = false

func _on_map_button_toggled(toggled_on: bool) -> void:
	map.visible = !map.visible
