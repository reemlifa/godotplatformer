extends Area2D

@onready var animated_sprite = $AnimatedSprite2D
@export var pink_door: StaticBody2D  # Reference to the cyanBook scene

func _ready():
	animated_sprite.play("idle")

func _on_body_entered(body):
	if body.is_in_group("player"):
		# Debugging: Print the player's position and velocity when entering the lever area
		print("Player entered lever area.")
		print("Player position: ", body.position)
		print("Player velocity: ", body.velocity)

		var player_velocity = body.velocity.x
		if player_velocity > 0:  # Player moving from right to left
			print("Player moving right to left.")
			animated_sprite.play("on")
			if pink_door:
				pink_door.set_door_state(true)  # Open the book
		elif player_velocity < 0:  # Player moving from left to right
			print("Player moving left to right.")
			animated_sprite.play("off")
			if pink_door:
				pink_door.set_door_state(false)  # Close the book

		# Additional check for any unexpected position change
		print("Player position after interaction: ", body.position)
		print("--------------------------------------------------")
