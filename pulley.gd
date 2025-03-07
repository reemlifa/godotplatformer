extends Node2D

@onready var platform1 = $"pulley-platform1"
@onready var platform2 = $"pulley-platform2"

var platform_height = 10  # How far the platforms move
var weight_on_platform1 = false
var weight_on_platform2 = false

func _on_platform1_area_body_entered(body):
	weight_on_platform1 = true
	update_pulley_motion()
	print("player on platform 1")

func _on_platform1_area_body_exited(body):
	weight_on_platform1 = false
	update_pulley_motion()
	print("player left platform 1")

func _on_platform2_area_body_entered(body):
	weight_on_platform2 = true
	update_pulley_motion()
	print("player on platform 2")

func _on_platform2_area_body_exited(body):
	weight_on_platform2 = false
	update_pulley_motion()
	print("player left platform 2")

func update_pulley_motion():
	if weight_on_platform1 and not weight_on_platform2:
		move_platforms(-platform_height, platform_height)  
	elif weight_on_platform2 and not weight_on_platform1:
		move_platforms(platform_height, -platform_height)  
	else:
		move_platforms(0, 0) 

func move_platforms(offset1, offset2):
	platform1.position.y += offset1  
	platform2.position.y += offset2 
