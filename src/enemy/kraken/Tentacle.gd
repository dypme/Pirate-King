class_name Tentacle

extends Node2D

onready var initial_position: = global_position

onready var anim_player: = $AnimationPlayer
onready var state_machine: = $StateMachine

onready var water_sfx: = $WaterSFX
onready var attack_sfx: = $AttackSFX

func _ready() -> void:
	anim_player.play("move_in")

func attack() -> void:
	state_machine.attack()

func dead() -> void:
	global_position = initial_position
	anim_player.play("dead")
