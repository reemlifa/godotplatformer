extends Button

@onready var menu_panel = preload("res://menuPanel.tscn")  # Preload the menu panel scene

func _ready():
	self.pressed.connect(_on_menu_pressed)

func _on_menu_pressed():
	if not get_tree().current_scene.has_node("menuPanel"):  # Check if it's already added
		var panel_instance = menu_panel.instantiate()  # Create an instance
		get_tree().current_scene.add_child(panel_instance)  # Add it to the scene
		panel_instance.show()  # Make it visible
		get_tree().paused = true  # Pause the game
		print("Menu opened!")
	else:
		print("MenuPanel already exists")
