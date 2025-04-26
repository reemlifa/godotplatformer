extends StaticBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

func _ready():
	sprite.play("idle")

func set_door_state(open: bool):
	if open:
		sprite.play("moving")
		await sprite.animation_finished  # Wait for the 'moving' animation to finish
		sprite.play("done")  # Switch to empty frame to "remove" the book
		visible = false
		collision.set_deferred("disabled", true)
	else:
		visible = true
		collision.set_deferred("disabled", false)
		sprite.play("idle")
