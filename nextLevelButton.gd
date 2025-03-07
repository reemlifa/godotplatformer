extends Node

var current_level_index = 1  # Start from Level 1

func load_next_level():
	current_level_index += 1
	var next_level_path = "res://level" + str(current_level_index) + ".tscn"  # No underscore

	# Debug print to check the file path
	print("Trying to load:", next_level_path)

	if ResourceLoader.exists(next_level_path):
		print("Level exists, loading...")
		get_tree().change_scene_to_file(next_level_path)
	else:
		print("No more levels! You reached the end.")
