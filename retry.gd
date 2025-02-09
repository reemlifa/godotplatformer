extends Button

# Ensure the button is connected to the signal in the scene
func _ready() -> void:
	self.pressed.connect(_on_pressed)

# Function to reload the scene when the button is pressed
func _on_pressed() -> void:
	print("Retry button pressed! Reloading scene...")
	get_tree().reload_current_scene()
