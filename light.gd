extends Area2D

@onready var canvas_modulate = $"../CanvasModulate"
@onready var point_light = $"../CharacterBody2D/PointLight2D"
@onready var anim_sprite = $"../light/AnimatedSprite2D"
var can_toggle = false

func _on_Lightbulb_body_entered(body):
	if body is CharacterBody2D:
		can_toggle = true

func _on_Lightbulb_body_exited(body):
	if body is CharacterBody2D:
		can_toggle = false

func _ready():
	anim_sprite.play("off")

func _input(event):
	if can_toggle and event.is_action_pressed("interact"):
		if point_light.visible:
			point_light.visible = false
			if canvas_modulate.visible:
				canvas_modulate.hide()
			anim_sprite.play("on") # Should play "off" when turning off
		else:
			point_light.visible = true
			if canvas_modulate:
				canvas_modulate.show()
			anim_sprite.play("off") # Should play "on" when turning on
