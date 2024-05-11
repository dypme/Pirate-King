extends Node

var ship_health: = 150 setget set_health
var is_enemy_screaming: = false
var is_win: = false
var camera = null

signal ship_health_updated
signal game_over

func set_health(value: int) -> void:
	ship_health = value
	emit_signal("ship_health_updated")
	
	if ship_health <= 0:
		lose()

func reset() -> void:
	ship_health = 150
	is_enemy_screaming = false
	is_win = false

func win() -> void:
	camera.shake(100, 2)
	is_win = true
	emit_signal("game_over")
	
func lose() -> void:
	camera.shake(300, 2)
	is_win = false
	emit_signal("game_over")
