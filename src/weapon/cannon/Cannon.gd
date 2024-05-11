class_name Cannon

extends Weapon

var pre_ball = preload("res://src/weapon/cannon/CannonBall.tscn")
var pre_explosion = preload("res://src/effect/Explosion.tscn")
var pre_cannon_smoke = preload("res://src/effect/CannonSmoke.tscn")

onready var timer: = $Timer

var impulse = Vector2(200, -100)

func _ready() -> void:
	timer.wait_time = repetition
	control_area = $PlayerControl
	Singleton.connect("game_over", self, "_on_Game_over")

func fire() -> void:
	var ball = pre_ball.instance()
	ball.global_position = global_position + Vector2(25, -13)
	get_tree().current_scene.add_child(ball)
	ball.apply_central_impulse(impulse)
	
	var cannon_smoke = pre_cannon_smoke.instance()
	cannon_smoke.global_position = ball.global_position
	get_tree().current_scene.add_child(cannon_smoke)
	
	timer.start()

func _physics_process(delta: float) -> void:
	if Singleton.is_enemy_screaming:
		explode()

func _on_Game_over() -> void:
	if timer.time_left > 0:
		timer.stop()
	if not Singleton.is_win:
		explode()

func _on_Timer_timeout() -> void:
	fire()

func _on_Hurtbox_area_entered(area: Area2D) -> void:
	explode()

func explode() -> void:
	var explosion = pre_explosion.instance()
	explosion.global_position = global_position
	get_tree().current_scene.add_child(explosion)
	queue_free()
