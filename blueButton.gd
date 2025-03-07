extends Area2D

signal toggled(state: bool)  # Signal to notify the platform to toggle

@export var platform: NodePath  # Assign BlueBookPlatform node in Inspector
@onready var platform_node: StaticBody2D = get_node_or_null(platform)  # Ensure it's a valid node
@onready var sprite = $Sprite2D  # Reference to the button's sprite

var is_pressed: bool = false  # Ensure it's false at start

func _ready():
	if platform_node:
		print("Platform node found:", platform_node.name)
		if platform_node.has_method("reset"):
			platform_node.reset()  # Ensure the platform is at its starting position
	else:
		print("Error: Platform node not found!")

	# Connect signals
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)

# Trigger when any body enters the button's collision area
func _on_body_entered(body: Node):
	print("Body entered:", body.name)
	if not is_pressed:  # Only trigger if not already pressed
		print("Button pressed!")
		is_pressed = true
		sprite.visible = false  # Hide the button (pressed state)
		if platform_node and platform_node.has_method("lower"):
			print("Lowering platform...")
			platform_node.lower()  # Lower the platform
		toggled.emit(true)  # Notify that the platform has moved

# Trigger when any body exits the button's collision area
func _on_body_exited(body: Node):
	print("Body exited:", body.name)
	if is_pressed:  # If something was previously pressing the button
		print("Button released!")
		is_pressed = false
		sprite.visible = true  # Show the button again (unpressed state)
		if platform_node and platform_node.has_method("reset"):
			print("Resetting platform...")
			platform_node.reset()  # Reset the platform
		toggled.emit(false)  # Notify that the platform has returned to its original position
