extends Area2D

@export var player: CharacterBody2D  # Assign the player in the Inspector
var current_level_index = 1 

func _on_body_entered(body):
	if body is CharacterBody2D and body.has_key:  # Check if the player has the key
		print("Level Complete!")
		load_next_level()

func load_next_level():
	current_level_index += 1
	var next_level_path = "res://level" + str(current_level_index) + ".tscn"
	print("Trying to load:", next_level_path)

	if FileAccess.file_exists(next_level_path):
		print("Level exists, loading...")
		get_tree().call_deferred("change_scene_to_file", next_level_path)
	else:
		print("No more levels! You reached the end.")
