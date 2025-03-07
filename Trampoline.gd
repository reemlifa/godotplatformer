extends Area2D

@export var bounce_force: int = 1000  # Adjust to control bounce height
@onready var animated_sprite = $"../AnimatedSprite2D"  # Reference the animated sprite

func _on_body_entered(body):
	if body is CharacterBody2D:
		body.velocity.y = -bounce_force  # Apply bounce force
		body.jumps_left = 2  # Reset jumps if using double jump
		animated_sprite.play("compressed")  # Play the trampoline compression animation

		# Optional: Return to normal state after a short delay
		await get_tree().create_timer(0.2).timeout
		animated_sprite.play("normal")  # Play back to normal animation
