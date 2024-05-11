extends Node2D

export var attack_rate: = 0.4
export var min_attack_interval: = 7
export var max_attack_interval: = 9
export var health: = 200

enum {
	TENTACLE
	ROAR
	BOMB
}

onready var tentacle1: = $Tentacle
onready var tentacle2:  = $Tentacle2

onready var attack_timer: = $AttackTimer
onready var bomb_timer: = $WaterBallTimer

onready var anim_player: = $AnimationPlayer
onready var health_bar: = $HealthBar/Control/ProgressBar
onready var scream_sfx: = $ScreamSFX

var pre_water_bomb = preload("res://src/enemy/kraken/WaterBomb.tscn")

var total_bomb: = 0

func _ready() -> void:
	health_bar.min_value = 0
	health_bar.max_value = health
	health_bar.value = health
	Singleton.connect("game_over", self, "_on_Game_over")

func _on_AttackTimer_timeout() -> void:
	randomize()
	if randf() < attack_rate:
		attack()
		attack_rate = 0.5
	else:
		attack_rate += 0.1
	attack_timer.wait_time = rand_range(min_attack_interval, max_attack_interval)

func attack() -> void:
	match random_attack():
		TENTACLE:
			randomize()
			var tentacle = tentacle1 if randf() < 0.5 else tentacle2
			tentacle.attack()
		ROAR:
			anim_player.play("roar")
			$RoarTimer.start()
			Singleton.is_enemy_screaming = true
			play_scream_sfx()
		BOMB:
			total_bomb = 0
			bomb_timer.start()

func random_attack() -> int:
	randomize()
	var prop = randf()
	if prop < 0.6:
		return TENTACLE
	elif prop < 0.9:
		return BOMB
	else:
		return ROAR

func fire() -> void:
	total_bomb += 1
	var bomb = pre_water_bomb.instance()
	bomb.global_position = Vector2(tentacle1.global_position.x, global_position.y)
	get_tree().current_scene.add_child(bomb)

func play_scream_sfx() -> void:
	scream_sfx.play()
	
func stop_scream_sfx() -> void:
	scream_sfx.stop()

func _on_Game_over() -> void:
	end()

func dead() -> void:
	Singleton.win()
	anim_player.play("dead")
	tentacle1.dead()
	tentacle2.dead()

func end() -> void:
	Singleton.is_enemy_screaming = false
	stop_scream_sfx()
	attack_timer.stop()
	bomb_timer.stop()
	$RoarTimer.stop()
	$Hurtbox/CollisionShape2D.set_deferred("disabled", true)

func _on_RoarTimer_timeout() -> void:
	anim_player.play("idle")
	stop_scream_sfx()
	Singleton.is_enemy_screaming = false

func _on_WaterBallTimer_timeout() -> void:
	if total_bomb < 3:
		fire()
	else:
		bomb_timer.stop()

func go_to_win_screen() -> void:
	SceneTransition.change_scene("res://src/scenes/Scene2.tscn")

func _on_Hurtbox_area_entered(area: Area2D) -> void:
	health -= area.damage
	health_bar.value = health
	if health < 140:
		attack_rate = 0.5
		min_attack_interval = 6
		max_attack_interval = 8
	
	if health < 90:
		attack_rate = 0.6
		min_attack_interval = 5
		max_attack_interval = 7
		
	if health <= 0:
		dead()
