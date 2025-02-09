extends Node

var current_level_index = 1  # Start from Level 1

func load_next_level():
	current_level_index += 1
	var next_level_path = "res://level_" + str(current_level_index) + ".tscn"
	
	# Check if the file exists before loading
	if ResourceLoader.exists(next_level_path):
		get_tree().change_scene_to_file(next_level_path)
	else:
		print("No more levels! You reached the end.")



	pass # Replace with function body.
