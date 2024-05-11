class_name DamagedDeck

extends StaticBody2D

signal finished

onready var timer: = $Timer

var smoke = null

var pre_smoke = preload("res://src/effect/Smoke.tscn")

onready var progress_bar: = $ProgressBuilder/Control/ProgressBar

func _ready() -> void:
	Singleton.connect("game_over", self, "_on_Game_over")

func build():
	timer.paused = false
	if timer.time_left <= 0:
		print("Repairing...")
		timer.start()
	
	smoke = pre_smoke.instance()
	add_child(smoke)

func stop_building():
	print("Pause repairing...")
	timer.paused = true
	if smoke:
		smoke.queue_free()
		smoke = null

func _process(delta: float) -> void:
	progress_bar.visible = timer.time_left > 0
	progress_bar.value = (timer.wait_time - timer.time_left) / timer.wait_time * 100

func can_build() -> bool:
	return (timer.paused or timer.time_left <= 0)

func complete() -> void:
	Singleton.ship_health += 9
	timer.stop()
	emit_signal("finished")
	queue_free()

func _on_Game_over() -> void:
	queue_free()

func _on_Timer_timeout() -> void:
	complete()
