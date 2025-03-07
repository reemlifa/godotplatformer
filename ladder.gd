extends Area2D

# Connect these signals to the player detection
func _on_body_entered(body):
	if body is CharacterBody2D:
		body.is_on_ladder = true
		body.velocity = Vector2.ZERO  # Stop player movement when on ladder
		body.position.x = position.x  # Snap the player to the ladder's X position

func _on_body_exited(body):
	if body is CharacterBody2D:
		body.is_on_ladder = false
