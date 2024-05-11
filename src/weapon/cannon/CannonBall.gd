extends RigidBody2D

var pre_post_effect = preload("res://src/effect/CannonExplode.tscn")

func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()	

func _on_Hitbox_area_entered(area: Area2D) -> void:
	explode()

func _physics_process(delta: float) -> void:
	if Singleton.is_enemy_screaming:
		explode()

func explode() -> void:
	var post_effect = pre_post_effect.instance()
	post_effect.global_position = global_position
	get_tree().current_scene.add_child(post_effect)
	queue_free()
