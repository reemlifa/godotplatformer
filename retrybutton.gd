extends Button

func _ready() -> void:
	self.pressed.connect(_on_pressed)

func _on_pressed() -> void:
	print("Retry button pressed! Reloading scene...")
	get_tree().reload_current_scene()


func _on_retry_pressed() -> void:
	pass # Replace with function body.
