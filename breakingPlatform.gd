extends StaticBody2D

@onready var anim_sprite = $AnimatedSprite2D
@onready var collision_shape = $CollisionShape2D
@export var delay_before_break: float = 0.5  # Time before falling

var has_broken = false

func _ready():
	print("Breakable platform ready!")  
	anim_sprite.play("idle")
	# Ensure the area detects bod

func _on_body_entered(body):
	print("Collision detected with: ", body.name)  

	if body is CharacterBody2D:
		print("Collided object is a CharacterBody2D")  
	else:
		print("Collided object is NOT a CharacterBody2D")  

	if not has_broken:
		print("Platform is intact, starting break sequence...")  
		_play_break_animation()
	else:
		print("Platform already broken, ignoring collision.")  

func _play_break_animation():
	if has_broken:
		print("Break animation already triggered, exiting function.")  
		return
	
	has_broken = true 
	print("Starting break delay of ", delay_before_break, " seconds")  

	var timer = get_tree().create_timer(delay_before_break)
	await timer.timeout  
	print("Break delay finished, playing animation")  

	anim_sprite.play("animated")
	print("Animation should now be playing...")  

	await anim_sprite.animation_finished
	print("Animation finished, disabling collision and freeing platform.")  

	collision_shape.set_deferred("disabled", true)
	queue_free()
