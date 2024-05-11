extends PlayerState

const ACCELERATION: = 130

onready var sfx: = $SFX

func enter() -> void:
	player.anim_state.travel("move")
	sfx.play()

func input(event: InputEvent) -> void:
	.input(event)
	
	if Input.is_action_just_pressed("action"):
		if player.weapon:
			emit_signal("change_state", PlayerStateMachine.CONTROL)

func physics_update(delta: float) -> void:
	if player.get_input_vector() == Vector2.ZERO:
		emit_signal("change_state", PlayerStateMachine.IDLE)
		return
		
	player.anim_tree.set("parameters/idle/blend_position", player.get_input_vector())
	player.anim_tree.set("parameters/move/velocity/blend_position", player.get_input_vector())
	var input_vector = player.get_input_vector()
	if Singleton.is_enemy_screaming:
		input_vector.x -= 0.7
	player.accelerate_to_position(input_vector * player.speed, ACCELERATION * delta)
	
func exit() -> void:
	sfx.stop()
