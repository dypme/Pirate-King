class_name TentacleStateMachine

extends Node

enum {
	IDLE
	ATTACK
}

onready var state_maps: = {
	IDLE: $Idle,
	ATTACK: $Attack
}

var state = null

func _ready() -> void:
	for state_node in get_children():
		state_node.tentacle = owner
		state_node.connect("change_state", self, "_on_change_state")
	state = state_maps[IDLE]

func _unhandled_input(event: InputEvent) -> void:
	state.input(event)

func _physics_process(delta: float) -> void:
	state.physics_update(delta)
	
func _process(delta: float) -> void:
	state.update(delta)

func _on_change_state(new_state):
	state.exit()
	state = state_maps[new_state]
	owner.anim_player.play("move_out")

func _on_finish_animation_enter() -> void:
	state.enter()
	
func _on_finish_animation_exit() -> void:
	state.pre_enter()
	owner.water_sfx.play()
	owner.anim_player.play("move_in")

func attack() -> void:
	if state != $Attack:
		_on_change_state(ATTACK)
