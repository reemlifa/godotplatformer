extends Button

func _ready():
	# Connect the button press signal to the function
	connect("pressed", Callable(self, "_on_button_pressed"))

func _on_button_pressed():
	print("Loading Level Selection Screen...")
	get_tree().change_scene_to_file("res://levelselection.tscn")
