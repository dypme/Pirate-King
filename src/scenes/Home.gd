extends Node2D

onready var anim_player: = $AnimationPlayer

func next_cut_scene() -> void:
	SceneTransition.change_scene("res://src/scenes/Scene1.tscn")

func _unhandled_input(event: InputEvent) -> void:
	if anim_player.current_animation != "cut_scene":
		if Input.is_action_just_pressed("action"):
			anim_player.play("cut_scene")
			$CanvasLayer.visible = false
