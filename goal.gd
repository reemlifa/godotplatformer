extends Area2D

@onready var success_ui = get_tree().get_first_node_in_group("success_ui")  # Find UI
@onready var nextLevelButton = get_node_or_null("/root/Root/nextLevelButton")  # Ensure correct path

func _ready():
	call_deferred("_hide_next_level_button")

func _hide_next_level_button():
	if nextLevelButton:
		nextLevelButton.hide()
		print("nextLevelButton hidden at start")
	else:
		print("Error: nextLevelButton not found!")

func _on_body_entered(body):
	if body is CharacterBody2D:
		print("Level Complete! Stopping player and showing Next Level Button...")

		# Stop player movement
		if body.has_method("stop_movement"):
			body.stop_movement()
		else:
			body.velocity = Vector2.ZERO
			body.set_physics_process(false)

		# Show Next Level Button
		show_next_level_button()

func show_next_level_button():
	if nextLevelButton:
		nextLevelButton.show()
	else:
		print("Error: Could not find nextLevelButton!")
