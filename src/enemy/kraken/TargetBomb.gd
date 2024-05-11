extends Node2D

func _ready() -> void:
	Singleton.connect("game_over", self, "_on_Game_over")

func _on_Game_over() -> void:
	if not Singleton.is_win:
		queue_free()
