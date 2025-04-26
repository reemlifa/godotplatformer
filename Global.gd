extends Node

var current_level_index = 1  # Default to level 1

# This function is called when a new scene is loaded to update the current level
func initialize_level(level_index):
	current_level_index = level_index
