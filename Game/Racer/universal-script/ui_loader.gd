extends Node

# Set shortcut to the menu Panel
@onready var menuspace = get_node("/root/Second-track/CanvasLayer/MenuSpace")

# Flag for when the game starts and the time for the timer to be accessed globally
var running = false
var elapsed = Time.get_ticks_msec()

# Load the required menu to the Panel
func load_into_men_space(scene_path) -> void:
	# Clear the panel first
	for child in menuspace.get_children():
		if child.name != "SubViewportContainer":
			child.queue_free()
	
	# If close buton pressed, stop here
	if scene_path == "null":
		return
	
	# Load the new scene and instantiate it in the panel
	var scene = load(scene_path)
	var instance = scene.instantiate()
	menuspace.add_child(instance)
