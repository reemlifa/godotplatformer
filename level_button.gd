extends Button

@export_file("*.tscn") var level_scene: String  # Assign level file in the Inspector

func _ready():
	# Ensure the button is connected to the function
	if not pressed.is_connected(_on_pressed):
		pressed.connect(_on_pressed)
	print("Button for " + level_scene + " loaded!")

func _on_pressed():
	if level_scene.is_empty():
		print("Error: No level assigned!")
		return
	
	print("Loading Level: " + level_scene)

	# Ensure the correct level path format
	if not level_scene.begins_with("res://"):
		level_scene = "res://" + level_scene
	
	# Optional: Check for `purpleLever` before switching scenes
	var lever = get_parent().get_node_or_null("purpleLever")  # Adjust path if needed
	if lever:
		print("Found purpleLever! You can interact with it.")
	else:
		print("Warning: purpleLever node not found.")
	
	# Ensure the level file exists before changing the scene
	if ResourceLoader.exists(level_scene):
		print("Level exists, loading...")
		get_tree().call_deferred("change_scene_to_file", level_scene)  # Deferred to prevent issues
	else:
		print("Error: Scene not found at " + level_scene)
