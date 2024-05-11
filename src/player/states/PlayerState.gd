class_name PlayerState

extends Node

signal change_state(new_state)

var player = null

func enter() -> void:
	pass
	
func exit() -> void:
	pass
	
func input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("action"):
		if player.builder and player.builder.can_build():
			emit_signal("change_state", PlayerStateMachine.BUILD)
		if player.weapon and player.weapon.can_control():
			emit_signal("change_state", PlayerStateMachine.CONTROL)
		if player.damaged and player.damaged.can_build() :
			emit_signal("change_state", PlayerStateMachine.REPAIR)

func physics_update(delta: float) -> void:
	pass

func update(delta: float) -> void:
	pass

func action_complete() -> void:
	pass
