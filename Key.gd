extends Area2D

signal key_collected

func _on_body_entered(body):
	if body is CharacterBody2D:  # Make sure it's the player
		print("Player collected the key!")
		if body.has_method("collect_key"):  
			body.collect_key()  # Call the function in the player script
		key_collected.emit()  # Emit signal for any other logic (like opening a door)
		queue_free()  # Remove key
