extends Node2D


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is CharacterBody2D:
		# Ensure we call _reload_scene deferred, but after the frame is finished.
		call_deferred("_reload_scene")

func _reload_scene() -> void:
	var tree = get_tree()
	if tree != null:
		tree.reload_current_scene()
	else:
		print("Scene tree is not available.")
