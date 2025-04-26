extends Area2D

@onready var animated_sprite = $AnimatedSprite2D

@export var forestGreen_book: StaticBody2D  # Reference to the cyanBook scene

func _ready():
	animated_sprite.play("idle")

func _on_body_entered(body):
	if body.is_in_group("player"):
		var player_velocity = body.velocity.x
		if player_velocity > 0:  # Player moving from right to left
			animated_sprite.play("on")
			if forestGreen_book:
				forestGreen_book.set_door_state(true)  # Open the book
		elif player_velocity < 0:  # Player moving from left to right
			animated_sprite.play("off")
			if forestGreen_book:
				forestGreen_book.set_door_state(false)  # Close the book
