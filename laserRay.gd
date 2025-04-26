extends RayCast2D

@onready var line: Line2D = $Line2D
var ray_target_position: Vector2 = Vector2(1000, 0)

func _ready():
	line.width = 2
	line.default_color = Color.RED
	target_position = ray_target_position

func _physics_process(delta):
	force_raycast_update()
	target_position = ray_target_position
	
	if is_colliding():
		var collision_point = get_collision_point()
		ray_target_position = collision_point - global_position
		line.points = [Vector2.ZERO, to_local(collision_point)]
	else:
		ray_target_position = Vector2(1000, 0)
		line.points = [Vector2.ZERO, ray_target_position]

	print("Ray endpoint:", ray_target_position)
