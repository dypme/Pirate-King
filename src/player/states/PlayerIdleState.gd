extends PlayerState

func enter() -> void:
	player.anim_state.travel("idle")
	pass
	
func physics_update(delta: float) -> void:
	if player.get_input_vector() != Vector2.ZERO:
		emit_signal("change_state", PlayerStateMachine.MOVE)
		return
	var idle_vector = Vector2.ZERO
	if Singleton.is_enemy_screaming:
		idle_vector.x -= 0.7
	player.accelerate_to_position(idle_vector * player.speed, player.FRICTION * delta)
	pass
