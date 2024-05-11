extends Node2D

var pre_arrow_l = preload("res://assets/sprites/arrow-left.png")
var pre_arrow_r = preload("res://assets/sprites/arrow-right.png")
var pre_arrow_u = preload("res://assets/sprites/arrow-up.png")
var pre_arrow_d = preload("res://assets/sprites/arrow-down.png")

onready var sprite1: = $Sprite
onready var sprite2: = $Sprite2
onready var sprite3: = $Sprite3
onready var timer: = $Timer
onready var correct_sfx: = $CorrectSFX
onready var wrong_sfx: = $WrongSFX

signal complete

enum {
	UP,
	DOWN,
	LEFT,
	RIGHT
}

var is_active = false
var targets = []
var current_index = null

var texture_maps = {
	UP : pre_arrow_u,
	DOWN : pre_arrow_d,
	LEFT : pre_arrow_l,
	RIGHT : pre_arrow_r
}

onready var sprites = [sprite1, sprite2, sprite3]

func _unhandled_input(event: InputEvent) -> void:
	if is_active:
		if Input.is_action_just_pressed("ui_up"):
			check_input(UP)
		elif Input.is_action_just_pressed("ui_down"):
			check_input(DOWN)
		elif Input.is_action_just_pressed("ui_left"):
			check_input(LEFT)
		elif Input.is_action_just_pressed("ui_right"):
			check_input(RIGHT)

func start() -> void:
	visible = true
	targets = []
	for i in 3:
		var target = get_target()
		targets.append(target)
		sprites[i].modulate = Color("#ffffff")
		sprites[i].set_texture(texture_maps[target])
	current_index = 0
	is_active = true

func stop() -> void:
	visible = false
	timer.stop()
	is_active = false
	
func check_input(input: int) -> void:
	if current_index > targets.size() - 1:
		return
	if input == targets[current_index]:
		correct_sfx.play()
		sprites[current_index].modulate = Color("#34FF6D")
		current_index += 1
		if current_index > targets.size() - 1:
			timer.start()
			emit_signal("complete")
	else:
		wrong_sfx.play()
		current_index = 0
		for i in 3:
			sprites[i].modulate = Color("#ffffff")

func get_target() -> int:
	randomize()
	var datas = [UP, DOWN, RIGHT, LEFT]
	datas.shuffle()
	return datas.pop_front()

func _on_Timer_timeout() -> void:
	start()
