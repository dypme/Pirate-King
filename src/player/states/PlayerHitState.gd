extends PlayerState

onready var timer: = $Timer
onready var sfx: = $SFX

func enter() -> void:
	Singleton.camera.shake(100, 0.4)
	player.hurtbox_collision.set_deferred("disabled", true)
	
	player.anim_state.travel("hit")
	player.velocity = player.knockback_vector * 150
	
	timer.start()
	sfx.play()
	player.dizzy_anim.visible = true

func input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("action"):
		print("Press when hit")
	
func physics_update(delta: float) -> void:
	var idle_vector = Vector2.ZERO
	if Singleton.is_enemy_screaming:
		idle_vector.x -= 0.7
	player.accelerate_to_position(idle_vector * player.speed, player.FRICTION * delta)
	
func exit() -> void:
	player.hurtbox_collision.disabled = false
	player.dizzy_anim.visible = false

func _on_Timer_timeout() -> void:
	emit_signal("change_state", PlayerStateMachine.IDLE)
