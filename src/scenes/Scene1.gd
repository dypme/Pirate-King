extends Node2D

func _ready() -> void:
	Singleton.reset()

func battle_scene() -> void:
	SceneTransition.change_scene("res://src/scenes/Gameplay.tscn")
