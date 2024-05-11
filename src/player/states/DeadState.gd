extends PlayerState

var dead_vector: = Vector2.ZERO

const ACCELERATION: = 300

func enter() -> void:
	randomize()
	var x = 1 if randf() > 0.5 else -1
	var y = 1 if randf() > 0.5 else -1
	dead_vector = Vector2(x, y)
	player.anim_state.travel("idle")
	player.hurtbox_collision.set_deferred("disabled", true)
	player.collision_shape.set_deferred("disabled", true)

func physics_update(delta: float):
	player.rotation_degrees += delta * 200
	player.accelerate_to_position(dead_vector * player.speed, ACCELERATION * delta)
