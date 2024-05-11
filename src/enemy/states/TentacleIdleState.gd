extends TentacleState

func pre_enter() -> void:
	tentacle.global_position = tentacle.initial_position

func enter() -> void:
	tentacle.anim_player.play("idle")
