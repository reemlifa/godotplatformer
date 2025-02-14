extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const PUSH_FORCE = 500.0
const MAX_JUMPS = 2  # Max jumps (1 normal jump + 1 double jump)

@onready var raycast = $RayCast2D  # Raycast to detect the box
@onready var animated_sprite = $Player  # Reference to the AnimatedSprite2D node
@onready var coin_counter = 0

var jumps_left = MAX_JUMPS  # Track remaining jumps

func _physics_process(delta: float) -> void:
	var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Jumping logic
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():  # Reset jump count when on the floor
			jumps_left = MAX_JUMPS
		if jumps_left > 0:  # Allow jump if jumps are left
			velocity.y = JUMP_VELOCITY
			jumps_left -= 1  # Decrease the jump count
			animated_sprite.play("jump")  # Play jump animation

	# Movement
	var direction = Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * SPEED if direction != 0 else move_toward(velocity.x, 0, SPEED)

	# Update animation and flip sprite
	if direction != 0:
		animated_sprite.flip_h = direction > 0  # Flip the sprite based on direction
		if is_on_floor():  # Play run animation if moving on the ground
			animated_sprite.play("run")
	elif is_on_floor():
		animated_sprite.play("idle")  # Play idle animation when not moving

	move_and_slide()

	# Object Pushing with RayCast
	if raycast.is_colliding():
		var obj = raycast.get_collider()
		if obj is RigidBody2D:  # If it's a RigidBody2D (the box)
			# Apply the push force using apply_impulse in Godot 4
			var direction_vector = Vector2(direction * PUSH_FORCE, 0)
			# Apply the impulse to the object in the direction the player is facing
			obj.apply_impulse(obj.position, direction_vector)

# Handle Coin Collection
func _on_coin_collected() -> void:
	coin_counter += 1
	print("Coins:", coin_counter)

# Detect Coins Entering Area2D
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("coin"):
		_on_coin_collected()
		area.queue_free()  # Remove the coin after collection
