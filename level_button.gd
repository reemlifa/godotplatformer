extends Button

@export_file("*.tscn") var level_scene: String


func _ready():
	if not self.pressed.is_connected(_on_pressed):
		self.pressed.connect(_on_pressed)  # Connect button signal
	print("Button for " + level_scene + " loaded!")

func _on_pressed():
	if level_scene:
		print("Loading Level: " + level_scene)
		if ResourceLoader.exists(level_scene):  # Ensure the scene exists
			get_tree().change_scene_to_file(level_scene)
		else:
			print("Error: Scene not found at " + level_scene)
	else:
		print("Error: No level assigned!")
		


func _on_level_2_pressed() -> void:
	pass # Replace with function body.
