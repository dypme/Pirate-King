class_name PlayerStateMachine

extends Node

enum {
	IDLE
	MOVE
	CONTROL
	BUILD
	HIT
	REPAIR
	DEAD
}

onready var state_maps: = {
	IDLE: $Idle,
	MOVE: $Move,
	CONTROL: $Control,
	BUILD: $Build,
	HIT: $Hit,
	REPAIR: $Repair,
	DEAD: $Dead
}

var state = null

func _ready() -> void:
	for state_node in get_children():
		state_node.player = owner
		state_node.connect("change_state", self, "_on_change_state")
	state = state_maps[IDLE]
	Singleton.connect("game_over", self, "_on_Game_over")

func _on_Game_over() -> void:
	if not Singleton.is_win:
		_on_change_state(DEAD)

func _unhandled_input(event: InputEvent) -> void:
	state.input(event)

func _physics_process(delta: float) -> void:
	state.physics_update(delta)
	
func _process(delta: float) -> void:
	state.update(delta)
	
func action_complete() -> void:
	state.action_complete()

func _on_change_state(new_state):
	state.exit()
	state = state_maps[new_state]
	state.enter()
