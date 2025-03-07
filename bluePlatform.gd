extends StaticBody2D

@export var blueButton: Node  # Reference to the blue button node (set in Inspector)
const MOVE_DISTANCE = 120  # Distance to move down when button is toggled
const MOVE_SPEED = 50  # Speed of platform movement
const STOP_THRESHOLD = 0.5  # Threshold to stop movement (avoids jitter)

var original_position: Vector2  # Store the original position of the platform
var target_position: Vector2  # The target position when toggled
var is_moving: bool = false  # Track movement

func _ready():
	original_position = position  # Store initial position
	target_position = original_position  # Default target position

	# Ensure the blueButton exists before connecting
	if blueButton:
		blueButton.connect("toggled", Callable(self, "_on_blueButton_toggled"))
		print("Blue Button connected.")  # Debugging message
	else:
		print("Blue Button node not assigned!")  # Debugging error

# Function triggered when the blue button is toggled
func _on_blueButton_toggled(state: bool) -> void:
	print("Blue Button toggled. State: ", state)  # Debugging message

	# Update target position based on the button state
	if state:
		target_position = original_position + Vector2(0, MOVE_DISTANCE)  # Move down
	else:
		target_position = original_position  # Move back up
	
	is_moving = true  # Start moving the platform

# Move platform towards target
func _process(delta: float) -> void:
	if is_moving:
		move_to_position(target_position, delta)

# Smooth movement towards the target position
func move_to_position(target: Vector2, delta: float) -> void:
	var direction = target - position

	if direction.length() > STOP_THRESHOLD:
		position += direction.normalized() * MOVE_SPEED * delta  # Move towards the target
	else:
		position = target  # Snap to exact position when close enough
		is_moving = false  # Stop movement
		print("Platform movement complete.")
