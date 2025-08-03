extends CharacterBody2D
class_name Planet

@export var planet_id: int
var time_elapsed = 0.0

func _physics_process(delta: float) -> void:
	time_elapsed += delta
	velocity = velocity.move_toward(30.0 * Vector2(sin(time_elapsed + planet_id), cos(time_elapsed + planet_id)), 20.0)
	move_and_slide()
