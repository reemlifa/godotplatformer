extends Node2D

@onready var incident_ray: RayCast2D = $IncidentRayCast
@onready var reflected_ray: RayCast2D = $ReflectedRayCast
@onready var incident_line: Line2D = $IncidentLine
@onready var reflected_line: Line2D = $ReflectedLine
@onready var boxMirror: RigidBody2D = get_node("../../boxMirror")

var incident_target: Vector2 = Vector2.ZERO
var reflected_target: Vector2 = Vector2.ZERO
var smooth_factor: float = 0.1
var current_target: Vector2 = Vector2(1000, 0)

func _ready() -> void:
	incident_ray.target_position = current_target

func _process(delta: float) -> void:
	_update_ray_lines()

func _physics_process(delta: float) -> void:
	incident_ray.force_raycast_update()
	reflected_ray.force_raycast_update()

	if incident_ray.is_colliding():
		var incident_collision_point = incident_ray.get_collision_point()
		var incident_body = incident_ray.get_collider()

		if incident_body == boxMirror:
			if incident_body.get_child_count() > 0:
				incident_body = incident_body.get_children()[0]
			else:
				return  

			var mid_point = incident_body.shape.size.y / 2
			current_target = Vector2(incident_collision_point.y + mid_point - global_position.y, 0)
			incident_ray.target_position = current_target
			reflected_ray.position = current_target
			reflected_target = Vector2(1000, 0)

		if reflected_ray.is_colliding():
			var reflected_collision_point = reflected_ray.get_collision_point()
			reflected_target = Vector2(reflected_collision_point.x - reflected_ray.global_position.x, 0)

			reflected_ray.target_position = reflected_target
		else:
			_update_laser()
	else:
		_update_laser()

	incident_ray.target_position = incident_ray.target_position.lerp(current_target, smooth_factor)

	_update_ray_lines()

func _update_laser():
	if incident_ray.is_colliding():
		var collision_point = incident_ray.get_collision_point()
		current_target = collision_point - global_position
		incident_ray.target_position = to_local(collision_point)
	else:
		current_target = Vector2(1000, 0)
		incident_ray.target_position = current_target

func _update_ray_lines():
	var incident_start = incident_ray.position
	var incident_end = incident_ray.to_local(incident_ray.get_collision_point()) if incident_ray.is_colliding() else incident_ray.target_position
	incident_line.points = [incident_start, incident_end]

	var reflected_start = reflected_ray.global_position
	var reflected_end = reflected_ray.get_collision_point() if reflected_ray.is_colliding() else reflected_ray.global_position + reflected_ray.target_position

	reflected_start = reflected_line.to_local(reflected_start)
	reflected_end = reflected_line.to_local(reflected_end)

	reflected_line.points = [reflected_start, reflected_end]
