extends PlayerState

func enter() -> void:
	player.weapon.player = player
	
	player.velocity = Vector2.ZERO
	player.global_position = player.weapon.control_area.global_position
	player.anim_tree.set("parameters/idle/blend_position", Vector2.RIGHT)
	player.anim_tree.set("parameters/move/velocity/blend_position", Vector2.RIGHT)
	player.anim_state.travel("idle")
	player.player_action.start()

func input(event: InputEvent) -> void:
	if player.get_input_vector() != Vector2.ZERO:
		emit_signal("change_state", PlayerStateMachine.MOVE)

func exit() -> void:
	player.player_action.stop()
	if player.weapon:
		player.weapon.player = null

func action_complete() -> void:
	if player.weapon:
		player.weapon.fire()
