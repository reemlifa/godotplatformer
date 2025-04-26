extends StaticBody2D

@onready var anim_sprite = $AnimatedSprite2D  # Reference to AnimatedSprite2D

@export var fall_delay: float = 2  # Time before falling
@export var fall_distance: float = 520 # How far it falls
@export var fall_duration: float = 1.5  # Time it takes to fall

var has_fallen = false  # Track if it has already fallen

func _ready():
	anim_sprite.play("idle")  # Default idle animation

func fall():
	if has_fallen:
		return  # Prevent falling multiple times

	has_fallen = true  # Mark platform as fallen
	anim_sprite.play("shake")  # Play shaking animation

	await get_tree().create_timer(0.5).timeout  # Shake for 0.5 seconds
	await get_tree().create_timer(fall_delay - 0.5).timeout  # Wait for the rest of fall_delay

	# Create a tween for smooth falling
	var tween = create_tween()
	tween.tween_property(self, "global_position:y", global_position.y + fall_distance, fall_duration).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)

	await tween.finished  # Wait for the tween to complete
	set_deferred("collision_layer", 0)  # Disable collision
	anim_sprite.play("off")  # Change to "off" animation

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not has_fallen:  # Ensure player is in "player" group
		fall()
