extends StaticBody2D

@export var pink_door: StaticBody2D  # Reference to the Node containing the door script

var raycast: RayCast2D  # Reference to the RayCast2D node

func _ready():
	raycast = get_node("/root/level5/LaserSystem/RaycastHost/IncidentRayCast")
	if raycast:
		raycast.enabled = true

func _process(delta):
	if raycast and raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider and collider.name == "LaserDetector":  # Check if the collider is the laser
			on_laser_hit()

# Function triggered when laser hits the detector
func on_laser_hit():
	if pink_door:
		if pink_door.has_method("set_door_state"):
			pink_door.set_door_state(true)  # This opens the door
