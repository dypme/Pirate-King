class_name Weapon

extends Node2D

export var damage: = 1
export var repetition: = 2
export var build_time: = 3

var control_area = null
var player = null

func fire() -> void:
	pass

func can_control() -> bool:
	return player == null
