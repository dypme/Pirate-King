extends Camera2D

onready var timer: = $Timer
onready var tween: = $Tween

var shake_amount = 100
var default_offset = offset

func _ready() -> void:
	Singleton.camera = self
	set_process(false)
	
func _process(delta: float) -> void:
	offset = Vector2(rand_range(-shake_amount, shake_amount), rand_range(-shake_amount, shake_amount)) * delta + default_offset
	
func shake(amount: int, duration: float):
	shake_amount = amount
	tween.stop_all()
	set_process(true)
	timer.wait_time = duration
	timer.start()

func _on_Timer_timeout() -> void:
	set_process(false)
	tween.interpolate_property(self, "offset", offset, default_offset, 0.1, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	tween.start()
