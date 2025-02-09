extends Control

@onready var resume = $Panel/resume
@onready var mainMenu = $Panel/mainMenu
@onready var retryButton = $Panel/retryButton

func _ready():
	# Debugging: Check if buttons exist
	print_debug("Resume Button Exists:", resume != null)
	print_debug("Main Menu Button Exists:", mainMenu != null)
	print_debug("Retry Button Exists:", retryButton != null)

	# Ensure buttons exist before connecting signals
	if resume and not resume.pressed.is_connected(_on_resume_pressed):
		resume.pressed.connect(_on_resume_pressed)

	if mainMenu and not mainMenu.pressed.is_connected(_on_menu_pressed):
		mainMenu.pressed.connect(_on_menu_pressed)

	if retryButton and not retryButton.pressed.is_connected(_on_retry_pressed):
		retryButton.pressed.connect(_on_retry_pressed)

	hide()  # Hide the menu at the start

func _on_resume_pressed():
	print_debug("Resume Button Pressed!")
	get_tree().paused = false  # Unpause the game
	hide()  # Hide the menu

func _on_menu_pressed():
	print_debug("Main Menu Button Pressed!")
	get_tree().paused = false  # Unpause before switching scenes
	get_tree().change_scene_to_file("res://mainmenu.tscn")  # Update the correct path

func _on_retry_pressed():
	print_debug("Retry Button Pressed!")
	get_tree().paused = false  # Unpause before restarting
	get_tree().reload_current_scene()  # Reload the current level
