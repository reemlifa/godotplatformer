extends CharacterBody2D

const SPEED = 300
const JUMP_VELOCITY = -400.0
const MOVE_VERTICAL_SPEED = 200  # Speed for vertical movement

func _physics_process(delta: float) -> void:
	# Get the horizontal movement direction (1 for right, -1 for left, 0 for no movement)
	var direction := Input.get_axis("ui_left", "ui_right")
	
	# Set the velocity for horizontal movement
	velocity.x = direction * SPEED
	
	# Handle vertical movement (up and down)
	if Input.is_action_pressed("ui_up"):
		velocity.y = -MOVE_VERTICAL_SPEED  # Move up
	elif Input.is_action_pressed("ui_down"):
		velocity.y = MOVE_VERTICAL_SPEED   # Move down
	else:
		velocity.y = 0  # Stop vertical movement if no up/down input

	# Apply the velocity and move the character
	move_and_slide()
