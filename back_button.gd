extends Button

func _ready() -> void:
	if not self.pressed.is_connected(_on_pressed):
		self.pressed.connect(_on_pressed)  # Ensure the button is connected
	print("Return Button script loaded!")  # Debugging check

func _on_pressed() -> void:
	print("Returning to Main Menu...")
	
	var scene_path = "res://mainmenu.tscn"  # Ensure this path matches your actual file

	# Check if the scene exists before trying to load it
	if ResourceLoader.exists(scene_path):
		get_tree().change_scene_to_file(scene_path)
	else:
		print("Error: Scene not found at " + scene_path)
