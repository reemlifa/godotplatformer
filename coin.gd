extends Area2D

signal collected  # Signal to notify collection

func _ready():
	$AnimatedSprite2D.play("spin")  # Play animation

func _on_body_entered(body):
	if body.is_in_group("player"):  # Ensure the player has the "player" group
		emit_signal("collected")
		queue_free()  # Remove the coin
