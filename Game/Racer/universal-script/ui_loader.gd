extends Node
@onready var menuspace = get_node("/root/Second-track/CanvasLayer/MenuSpace")

func load_into_men_space(scene_path) -> void:
	for child in menuspace.get_children():
		child.queue_free()
	if scene_path == "null":
		return
	
	var scene = load(scene_path)
	var instance = scene.instantiate()
	menuspace.add_child(instance)
