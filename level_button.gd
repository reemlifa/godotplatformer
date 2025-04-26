extends Button

@export var level_scene: PackedScene  # Assign the level scene in the Inspector

func _ready():
	if not is_connected("pressed", Callable(self, "_on_pressed")):
		connect("pressed", Callable(self, "_on_pressed"))
	
	if level_scene:
		print("Button for " + level_scene.resource_path + " loaded!")
	else:
		print("Warning: No level assigned to this button!")

func _on_pressed():
	if level_scene == null:
		print("Error: No level assigned!")
		return
	
	print("Loading Level: " + level_scene.resource_path)
	get_tree().call_deferred("change_scene_to_packed", level_scene)
