extends Area2D


var enemy_in_sight = []

func _on_gun_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	enemy_in_sight.append(body)

func _on_gun_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	enemy_in_sight.erase(body)

func _physics_process(delta: float) -> void:
	if enemy_in_sight.size() > 0:
		var target_enemy = enemy_in_sight.front()
		look_at(target_enemy.global_position)

func shoot():
	const BULLET = preload("res://bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_bullet)

func _on_timer_timeout() -> void:
	shoot()
