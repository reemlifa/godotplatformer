extends CharacterBody2D

# Constants
const SPEED = 250.0
const JUMP_VELOCITY = -400.0
const MAX_JUMPS = 2  # Max jumps (1 normal jump + 1 double jump)
const CLIMB_SPEED = 100.0  # Speed when climbing the ladder
const PUSH_FORCE = 200  # Force applied to push objects

# Variables
var jumps_left = MAX_JUMPS  # Track remaining jumps
var is_on_ladder := false  # Track if the player is on a ladder
var has_key = false  # Tracks if the player has the key

@onready var animated_sprite = $Player  # Reference to the AnimatedSprite2D node

func _physics_process(delta: float) -> void:
	var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

	# Apply gravity when not on ladder
	if not is_on_ladder and not is_on_floor():
		velocity.y += gravity * delta

	# Ladder climbing logic
	if is_on_ladder:
		# Allow horizontal movement
		var direction = Input.get_axis("ui_left", "ui_right")
		velocity.x = direction * SPEED  

		# Vertical movement (climbing)
		var climb_direction = Input.get_axis("ladder_up", "ladder_down")
		velocity.y = climb_direction * CLIMB_SPEED

	else:
		# Jumping logic
		if Input.is_action_just_pressed("ui_accept"):
			if is_on_floor():  
				jumps_left = MAX_JUMPS  # Reset jumps when on the ground
			if jumps_left > 0:  
				velocity.y = JUMP_VELOCITY
				jumps_left -= 1
				animated_sprite.play("jump")

		# Regular horizontal movement
		var direction = Input.get_axis("ui_left", "ui_right")
		velocity.x = direction * SPEED if direction != 0 else move_toward(velocity.x, 0, SPEED)

		# Pushable box logic
		_push_box(direction)

		# Update animation and flip sprite
		if direction != 0:
			animated_sprite.flip_h = direction > 0
			if is_on_floor():
				animated_sprite.play("run")
		elif is_on_floor():
			animated_sprite.play("idle")

	move_and_slide()

# Push box when colliding with RigidBody2D
func _push_box(direction: float) -> void:
	if direction == 0:
		return  # Don't push if not moving

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var obj = collision.get_collider()

		if obj is RigidBody2D:
			obj.apply_central_impulse(Vector2(PUSH_FORCE * direction, 0))  # Apply push force

# Ladder enter logic
func _on_ladder_body_entered(body):
	if body is CharacterBody2D:
		body.is_on_ladder = true
		body.velocity = Vector2.ZERO  
		body.position.x = position.x  
		print("Player entered ladder area")  

# Ladder exit logic
func _on_ladder_body_exited(body):
	if body is CharacterBody2D:
		body.is_on_ladder = false
		body.velocity = Vector2.ZERO  
		print("Player exited ladder area")  
func collect_key():
	has_key = true
	print("Key collected!")
