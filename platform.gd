extends StaticBody2D

@export var lever: Node  # Reference to the lever node (set in the Inspector)
const MOVE_DISTANCE = 120  # Distance to move down when the lever is toggled right
const MOVE_SPEED = 50  # Speed at which the platform moves
const STOP_THRESHOLD = 0.5  # Threshold for when the platform should stop moving (avoids overshooting)

var original_position: Vector2  # Store the original position of the platform
var target_position: Vector2  # The target position where the platform is moving
var is_moving_down: bool = false  # Track whether the platform should be moving down
var lever_connected: bool = false  # Flag to ensure the signal is connected only once

func _ready():
	original_position = position  # Store the initial position of the platform
	target_position = original_position  # Initially, target position is the original position
	
	# Check if the lever is assigned and the signal is not connected yet
	if lever and not lever_connected:
		lever.connect("toggled", Callable(self, "_on_lever_toggled"))  # Connect the lever's toggled signal
		lever_connected = true  # Mark the lever as connected
		print("Lever connected.")  # Debugging message
	else:
		print("Lever node not found or already connected.")  # Debugging message if lever is not found or already connected

# Function to handle the lever toggled signal
func _on_lever_toggled(state: bool) -> void:
	print("Lever toggled. State: ", state)  # Debugging message to check the state
	if state:  # Lever is toggled to the right
		target_position = original_position + Vector2(0, MOVE_DISTANCE)
		is_moving_down = true
		print("Moving platform down.")
	else:  # Lever is toggled to the left
		target_position = original_position
		is_moving_down = false
		print("Platform at original position.")

# Smoothly move the platform
func _process(delta: float) -> void:
	# If the platform is not at the target position, move towards it
	if position != target_position:
		move_to_position(target_position, delta)

# Smoothly transition the platform to the target position
func move_to_position(target_position: Vector2, delta: float) -> void:
	var direction = target_position - position
	position += direction.normalized() * MOVE_SPEED * delta

	# Stop moving if we are close enough to the target position
	if direction.length() < STOP_THRESHOLD:
		position = target_position  # Directly set to target position to avoid small errors
