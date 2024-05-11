extends Node2D

var pre_big_explode = preload("res://src/effect/BigExplosion.tscn")

func _ready() -> void:
	Singleton.connect("game_over", self, "_on_Game_over")
	
func _on_Game_over() -> void:
	if not Singleton.is_win:
		var big_explode = pre_big_explode.instance()
		big_explode.connect("peak_explosion", self, "queue_free")
		big_explode.global_position = global_position
		get_tree().current_scene.add_child(big_explode)
