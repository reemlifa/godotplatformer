extends RigidBody2D

func _integrate_forces(state):
	var velocity = state.linear_velocity
	velocity.x = 0  # Prevents horizontal movement
	state.linear_velocity = velocity
