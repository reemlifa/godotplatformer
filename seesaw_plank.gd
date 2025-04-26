extends RigidBody2D

@export var swing_strength: float = 5000.0  # Strength of the swinging effect
@export var damping_factor: float = 0.99  # How quickly the swing slows down (lower values = faster damping)
@onready var left_area = $"/root/level6/Seesaw/LeftArea"  # Adjusted path to access LeftArea directly
@onready var right_area = $"/root/level6/Seesaw/RightArea"

func _ready():
	pass
func _physics_process(delta):
	var applied_torque = 0.0
	
	# Check if the player is in the left area (step on left side of the seesaw)
	for body in left_area.get_overlapping_bodies():
		if body.is_in_group("Player"):  # If the body is the player
			applied_torque = swing_strength  # Apply torque to swing left

	# Check if the player is in the right area (step on right side of the seesaw)
	for body in right_area.get_overlapping_bodies():
		if body.is_in_group("Player"):  # If the body is the player
			applied_torque = -swing_strength  # Apply torque to swing right

	# Apply torque to the platform to simulate the swinging motion
	apply_torque(applied_torque * delta)  # Apply torque based on detected area

	# Apply angular damping manually to slow down the swing gradually
	angular_velocity *= damping_factor  # Apply damping to reduce angular velocity
	
	# If the seesaw is tilted, gravity will naturally pull it down, so no need for extra damping for gravity
