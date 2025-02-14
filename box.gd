extends RigidBody2D

func _integrate_forces(state):
	if linear_velocity.length() > 0:
		linear_velocity = linear_velocity.lerp(Vector2.ZERO, state.step)

	# Prevent infinite sliding
	if abs(linear_velocity.x) < 2:
		linear_velocity.x = 0
