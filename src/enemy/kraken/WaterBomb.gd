extends KinematicBody2D

export var speed: = 100
var target = null

var pre_target = preload("res://src/enemy/kraken/TargetBomb.tscn")
var pre_damaged = preload("res://src/builder/DamagedDeck.tscn")
var pre_shockwave = preload("res://src/effect/Shockwave.tscn")

func _ready() -> void:
	rotation_degrees = 270
	Singleton.connect("game_over", self, "_on_Game_over")
	
func _physics_process(delta: float) -> void:
	if target:
		global_position.y += speed * delta
	else:
		global_position.y -= speed * delta
	
func _on_Game_over() -> void:
	if not Singleton.is_win:
		spawn_shockwave()
		queue_free()

func _on_VisibilityNotifier2D_screen_exited() -> void:
	randomize()
	var x = rand_range(40, 105)
	var y = rand_range(40, 190)
	global_position.x = x
	rotation_degrees = 90
	
	if target == null:
		target = pre_target.instance()
		target.global_position = Vector2(x, y)
		get_tree().current_scene.add_child(target)

func spawn_shockwave() -> void:
	var shockwave = pre_shockwave.instance()
	shockwave.global_position = global_position
	get_tree().current_scene.call_deferred("add_child", shockwave)
	
func spawn_damaged() -> void:
	var damaged_area = pre_damaged.instance()
	damaged_area.global_position = global_position
	get_tree().current_scene.call_deferred("add_child", damaged_area)

func _on_Hitbox_area_entered(area: Area2D) -> void:
	if area.owner == target:
		spawn_shockwave()
		Singleton.ship_health -= 10
		if Singleton.ship_health > 0:
			spawn_damaged()
		target.queue_free()
		queue_free()
