extends PlayerState

var builder = null

func enter() -> void:
	builder = player.builder
	builder.connect("finished", self, "_on_finish_build")
	builder.build()
	
	player.global_position = player.builder.global_position
	player.velocity = Vector2.ZERO
	player.area_detector.set_deferred("disabled", true)
	player.sprite.visible = false
	player.player_action.start()

func physics_update(delta: float) -> void:
	if player.get_input_vector() != Vector2.ZERO:
		emit_signal("change_state", PlayerStateMachine.MOVE)
		return
	player.accelerate_to_position(Vector2.ZERO, delta)

func exit() -> void:	
	player.global_position.x -= 10
	player.sprite.visible = true
	player.area_detector.set_deferred("disabled", false)
	player.player_action.stop()
	
	builder.stop_building()
	builder.disconnect("finished", self, "_on_finish_build")
	builder = null

func _on_finish_build() -> void:
	emit_signal("change_state", PlayerStateMachine.IDLE)
	
func action_complete() -> void:
	if builder:
		builder.complete()
