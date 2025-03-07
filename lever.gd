extends Area2D

signal toggled(state: bool)  # Signal to notify the platform or door

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var door = $"../Door"  # Reference to the door node

var is_left: bool = true  # Tracks the lever direction

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node):
	if body.is_in_group("player") and body is CharacterBody2D:  
		var player_direction = body.velocity.x  # Get player movement direction
		if player_direction != 0:  # Ensure player is moving
			flip_lever(player_direction)
			body.velocity.x += 50 * sign(player_direction)  # Apply force to push player slightly

func flip_lever(player_direction: float):
	if player_direction > 0:  # Moving right → Flip lever right
		is_left = false
	elif player_direction < 0:  # Moving left → Flip lever left
		is_left = true

	update_lever()
	toggled.emit(!is_left)  # Emit true if right, false if left

	# Control the door state based on the lever's position
	door.set_door_state(!is_left)  # Open door if lever is to the right (is_left = false)

func update_lever():
	if is_left:
		anim_sprite.play("left")  # Play left animation
	else:
		anim_sprite.play("right")  # Play right animation

	print("Lever switched to:", "Left" if is_left else "Right")
