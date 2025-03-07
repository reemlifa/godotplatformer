extends StaticBody2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

func set_door_state(open: bool):
	visible = !open  # Hide if open, show if closed
	collision.set_deferred("disabled", open)  # Disable collision when open
	print("Door is now", "Open" if open else "Closed")
