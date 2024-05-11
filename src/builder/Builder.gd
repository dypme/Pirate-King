class_name Builder

extends Area2D

signal finished

onready var timer: = $Timer

var weapon = null
var smoke = null
export var impulse = Vector2(200, -100)

var pre_cannon = preload("res://src/weapon/cannon/Cannon.tscn")
var pre_smoke = preload("res://src/effect/Smoke.tscn")

onready var progress_bar: = $ProgressBuilder/Control/ProgressBar

func build():
	if not can_build():
		return
	timer.paused = false
	if timer.time_left <= 0:
		print("Building...")
		timer.start()
	
	smoke = pre_smoke.instance()
	add_child(smoke)

func stop_building():
	print("Pause building...")
	timer.paused = true
	smoke.queue_free()
	smoke = null

func _process(delta: float) -> void:
	progress_bar.visible = timer.time_left > 0
	progress_bar.value = (timer.wait_time - timer.time_left) / timer.wait_time * 100
	if Singleton.is_enemy_screaming:
		weapon = null

func can_build() -> bool:
	return weapon == null and (timer.paused or timer.time_left <= 0)

func complete() -> void:
	timer.stop()
	emit_signal("finished")
	weapon = pre_cannon.instance()
	weapon.impulse = impulse
	add_child(weapon)

func _on_Timer_timeout() -> void:
	complete()

func _on_Builder_area_entered(area: Area2D) -> void:
	weapon = null
