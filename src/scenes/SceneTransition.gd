extends CanvasLayer

onready var anim_player: = $AnimationPlayer

func change_scene(target: String) -> void:
	anim_player.play("dissolve")
	yield(anim_player, "animation_finished")
	get_tree().change_scene(target)
	anim_player.play_backwards("dissolve")
