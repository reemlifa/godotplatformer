extends Area2D

@export var moving_platforms: NodePath  # Assign MovingPlatforms node in Inspector
@onready var moving_platforms_node: Node2D = get_node_or_null(moving_platforms)
@onready var sprite = $Sprite2D  # Reference to the button's sprite

var is_pressed: bool = false  # Tracks button state

func _ready():
	if moving_platforms_node:
		print("Moving platforms found:", moving_platforms_node.name)
	else:
		print("Error: Moving platforms node not found!")

	# Connect signals for detecting when something steps on or leaves the button
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)

# When player or box steps on the button
func _on_body_entered(body: Node):
	print("Body entered:", body.name)
	if not is_pressed:
		is_pressed = true
		sprite.visible = false  # Hide button (simulate being pressed)
		
		# Start moving platforms down
		if moving_platforms_node and moving_platforms_node.has_method("start_moving"):
			moving_platforms_node.start_moving()

# When player or box leaves the button
func _on_body_exited(body: Node):
	print("Body exited:", body.name)
	if is_pressed:
		is_pressed = false
		sprite.visible = true  # Show button again (simulate being unpressed)

		# Stop moving platforms if you want them to move back up when released
		# Uncomment this section if you want the platforms to stop moving
		# if moving_platforms_node and moving_platforms_node.has_method("stop_moving"):
		#     moving_platforms_node.stop_moving()
