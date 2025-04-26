extends Node2D

@onready var platform1 = $"pulley-platform1"
@onready var platform2 = $"pulley-platform2"

var platform_height = 100
var movement_limit = 100
var platform1_bodies = []  # List to track bodies on platform 1
var platform2_bodies = []  # List to track bodies on platform 2
var platform1_moving = false  
var platform2_moving = false

func _on_platform1_area_body_entered(body):
	if body is PhysicsBody2D and body not in platform1_bodies:
		platform1_bodies.append(body)
		print("Platform 1 detected:", body.name, "Weight:", get_body_weight(body))
	update_pulley_motion()

func _on_platform1_area_body_exited(body):
	if body is PhysicsBody2D and body in platform1_bodies:
		platform1_bodies.erase(body)
		print("Platform 1 removed:", body.name)
	update_pulley_motion()

func _on_platform2_area_body_entered(body):
	if body is PhysicsBody2D and body not in platform2_bodies:
		platform2_bodies.append(body)
		print("Platform 2 detected:", body.name, "Weight:", get_body_weight(body))
	update_pulley_motion()

func _on_platform2_area_body_exited(body):
	if body is PhysicsBody2D and body in platform2_bodies:
		platform2_bodies.erase(body)
		print("Platform 2 removed:", body.name)
	update_pulley_motion()

func get_body_weight(body):
	if body is RigidBody2D:
		return body.mass
	elif body is CharacterBody2D and "mass" in body:
		return body.mass  # Custom mass variable for CharacterBody2D
	return 0

func get_total_weight(platform_bodies):
	var total_weight = 0
	for body in platform_bodies:
		total_weight += get_body_weight(body)
	return total_weight

func update_pulley_motion():
	if platform1_moving or platform2_moving:
		return  # Prevent multiple movements from conflicting

	var platform1_weight = get_total_weight(platform1_bodies)
	var platform2_weight = get_total_weight(platform2_bodies)

	print("Platform 1 weight:", platform1_weight)
	print("Platform 2 weight:", platform2_weight)

	if platform1_weight > platform2_weight:
		move_platforms(-platform_height, platform_height)  # Platform 1 goes down, Platform 2 goes up
	elif platform2_weight > platform1_weight:
		move_platforms(platform_height, -platform_height)  # Platform 2 goes down, Platform 1 goes up
	else:
		move_platforms(0, 0)  # Keep platforms static if equal weight

func move_platforms(offset1, offset2):
	var target_pos1 = clamp(platform1.position.y + offset1, 0, movement_limit)
	var target_pos2 = clamp(platform2.position.y + offset2, 0, movement_limit)

	if platform1.position.y == target_pos1 and platform2.position.y == target_pos2:
		return  # No movement needed

	platform1_moving = true
	platform2_moving = true

	var tween = get_tree().create_tween()
	tween.set_parallel()

	tween.tween_property(platform1, "position:y", target_pos1, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(platform2, "position:y", target_pos2, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

	tween.finished.connect(_on_tween_completed)

func _on_tween_completed():
	platform1_moving = false
	platform2_moving = false

func _ready():
	platform1.position.y = movement_limit / 2
	platform2.position.y = movement_limit / 2
