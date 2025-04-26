extends Node2D

@export var move_speed: float = 25.0  # Speed of movement
@export var move_distance: float = 35.0  # How far the platforms should move down

var moving: bool = false
var moved_distance: float = 0.0  # Tracks how much the platforms have moved

func _process(delta):
	if moving and moved_distance < move_distance:
		var move_step = move_speed * delta
		for platform in get_children():
			platform.position.y += move_step  # Move down
		moved_distance += move_step

		# Stop moving once the target distance is reached
		if moved_distance >= move_distance:
			moving = false

func start_moving():
	moving = true
	moved_distance = 0.0  # Reset movement tracking
