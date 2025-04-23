extends Panel

# Set shortcuts to the Navbar items
@onready var men_space = get_node("../../MenuSpace")
@onready var close_but = $Button
@onready var map =  get_node("../../Map")

func _ready():
	# Make the close button and map invisble initially
	close_but.visible = false
	map.visible = false
	
	# When one of the menu buttons is clicked, goes to function
	var menu = $MenuButton.get_popup()
	menu.id_pressed.connect(_on_item_pressed)


func _on_item_pressed(id: int) -> void:
	# Match the correct menu screen to the panel on screen
	match id:
		0:
			UiLoader.load_into_men_space("res://main-menu/title-screen/title_screen.tscn")
		1:
			UiLoader.load_into_men_space("res://main-menu/controls/control.tscn")
	close_but.visible = true
		

func _on_button_pressed() -> void:
	# Empty the panel so the game can be seen again properly
	UiLoader.load_into_men_space("null")
	close_but.visible = false

func _on_map_button_toggled(toggled_on: bool) -> void:
	# Toggle the visibility of the map
	map.visible = !map.visible
