class_name Player

extends KinematicBody2D

const FRICTION: = 400

var velocity: = Vector2.RIGHT
var speed: = 100
var knockback_vector: = Vector2.ZERO

var builder = null
var damaged = null
var weapon = null

onready var dizzy_anim: = $Dizzy

onready var anim_tree: = $AnimationTree
onready var anim_state = anim_tree.get("parameters/playback")

onready var player_action: = $PlayerAction
onready var state_machine: = $StateMachine

onready var sprite: = $Sprite
onready var collision_shape: = $CollisionShape2D
onready var hurtbox_collision: = $Hurtbox/CollisionShape2D
onready var area_detector: = $AreaDetector/CollisionShape2D
onready var action_dialogue = $ActionDialogue

func _ready() -> void:
	player_action.connect("complete", state_machine, "action_complete")

func _physics_process(delta: float) -> void:
	update_action_indicator()

func get_input_vector() -> Vector2:
	var x = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y = Input.get_action_strength("down") - Input.get_action_strength("up")
	return Vector2(x, y).normalized()
	
func accelerate_to_position(new_position: Vector2, delta: float):
	velocity = velocity.move_toward(new_position, delta)
	velocity = move_and_slide(velocity)

func update_action_indicator() -> void:
	var has_action: = false
	if builder:
		if builder.can_build():
			has_action = true
	if weapon:
		if weapon.can_control():
			has_action = true
	if damaged:
		if damaged.can_build():
			has_action = true
	action_dialogue.visible = has_action

func _on_AreaDetector_area_entered(area: Area2D) -> void:
	if area.get_collision_layer_bit(3):
		builder = area
	if area.get_collision_layer_bit(4):
		weapon = area.owner
	if area.get_collision_layer_bit(10):
		damaged = area.owner

func _on_AreaDetector_area_exited(area: Area2D) -> void:
	if area.get_collision_layer_bit(3):
		builder = null
	if area.get_collision_layer_bit(4):
		weapon = null
	if area.get_collision_layer_bit(10):
		damaged = null

func _on_Hurtbox_area_entered(area: Area2D) -> void:
	knockback_vector = area.global_position.direction_to(global_position)
	state_machine._on_change_state(PlayerStateMachine.HIT)

func _on_VisibilityNotifier2D_screen_exited() -> void:
	if not Singleton.is_win:
		SceneTransition.change_scene("res://src/scenes/Gameover.tscn")
