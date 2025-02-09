extends Button

func _on_pressed():
	print("Going to Level Selection...")
	get_tree().change_scene_to_file("res://levelselection.tscn")  # Change path if needed


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
