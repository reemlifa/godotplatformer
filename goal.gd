extends Area2D

@export var player: CharacterBody2D  

func _ready():
	# Update the global level index based on the current scene
	var scene_name = get_tree().current_scene.scene_file_path.get_file().get_basename()
	var level_number = scene_name.replace("level", "").to_int()
	if level_number > 0:
		Global.initialize_level(level_number)  # Initialize the level index when the scene starts

func _on_body_entered(body):
	if body is CharacterBody2D and body.has_key:  
		print("Level Complete!")
		load_next_level()

func load_next_level():
	Global.current_level_index += 1  # Increment the global level index
	var next_level_path = "res://level" + str(Global.current_level_index) + ".tscn"
	print("Trying to load:", next_level_path)

	#if FileAccess.file_exists(next_level_path): 
	print("Level exists, loading...")
	get_tree().call_deferred("change_scene_to_file", next_level_path)  
	#else:
		#print("No more levels! Game completed.")
