extends Control

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	
func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")

func testEsc():
	if Input.is_action_just_pressed("esc") and !get_tree().paused: 
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused:
		resume()

func _on_button_3_pressed() -> void:
	resume()

func _on_button_2_pressed() -> void:
	get_tree().paused = false  # Ensure the game is unpaused
	$AnimationPlayer.stop()  # Stop the blur animation in case it's mid-play
	$AnimationPlayer.seek(0, true)  # Reset the animation to its starting frame
	get_tree().reload_current_scene()  # Reload the scene


func _on_button_pressed() -> void:
	get_tree().quit()

func _process(delta):
	testEsc()
