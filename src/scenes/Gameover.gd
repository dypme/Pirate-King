extends Control

var is_restarting = false

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("action") and not is_restarting:
		is_restarting = true
		SceneTransition.change_scene("res://src/scenes/Scene1.tscn")
