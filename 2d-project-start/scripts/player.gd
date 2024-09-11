extends CharacterBody2D

signal health_depleted

var health = 100.0
var speed = 600

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()
	if velocity:
		$HappyBoo.play_walk_animation()
	else:
		$HappyBoo.play_idle_animation()
		
		
	const DAMAGE_RATE = 5.0
	var overlapping_mobs = $Hurt_Box.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%ProgressBar.value = health
		if health <= 0.0:
			health_depleted.emit()
