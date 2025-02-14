extends StaticBody2D

@export var speed: float = 50.0  # Speed of movement
@export var move_distance: float = 184.0  # Moves 4 tiles (4 * 16 pixels)

var direction: int = -1  # Starts moving up
var start_position: Vector2

func _ready():
	start_position = global_position

func _process(delta):
	# Move the platform up and down
	global_position.y += speed * direction * delta

	# Reverse direction at limits (4 tiles up and down)
	if global_position.y <= start_position.y - move_distance:
		direction = 1  # Move down
	elif global_position.y >= start_position.y + move_distance:
		direction = -1  # Move up
