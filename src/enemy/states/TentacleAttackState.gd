extends TentacleState

func pre_enter() -> void:
	randomize()
	tentacle.global_position.x = 185
	tentacle.global_position.y = rand_range(45, 195)

func enter() -> void:
	tentacle.anim_player.play("attack")

func _on_Timer_timeout() -> void:
	tentacle.anim_player.play("attack_end")

func attack_end() -> void:
	emit_signal("change_state", TentacleStateMachine.IDLE)

func play_sfx() -> void:
	tentacle.attack_sfx.play()
