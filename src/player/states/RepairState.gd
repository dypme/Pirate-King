extends PlayerState

var damaged = null

func enter() -> void:
	damaged = player.damaged
	damaged.connect("finished", self, "_on_finish_build")
	damaged.build()
	
	player.velocity = Vector2.ZERO
	player.sprite.visible = false
	player.area_detector.set_deferred("disabled", true)
	player.player_action.start()

func physics_update(delta: float) -> void:
	if player.get_input_vector() != Vector2.ZERO:
		emit_signal("change_state", PlayerStateMachine.MOVE)
		return
	player.accelerate_to_position(Vector2.ZERO, delta)

func exit() -> void:
	damaged.stop_building()
	damaged.disconnect("finished", self, "_on_finish_build")
	damaged = null
	
	player.sprite.visible = true
	player.area_detector.set_deferred("disabled", false)
	player.player_action.stop()

func _on_finish_build() -> void:
	emit_signal("change_state", PlayerStateMachine.IDLE)

func action_complete() -> void:
	if damaged:
		damaged.complete()
