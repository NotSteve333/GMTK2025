extends CharacterBody2D

@export var cam_speed: float = 300.0

var direction: Vector2
var is_aware = false
var aware_spot: Vector2

func _process(delta: float) -> void:
	if !is_aware:
		var y_dir = Input.get_axis("up", "down")
		var x_dir = Input.get_axis("left", "right")
		direction = Vector2(x_dir, y_dir).normalized()
	else:
		direction = aware_spot - position

func _physics_process(delta: float) -> void:
	if !is_aware:
		velocity = velocity.move_toward(direction * cam_speed, cam_speed / 4.0)
	else:
		$Camera2D.zoom = $Camera2D.zoom * 1.04
		velocity = velocity.move_toward(direction, cam_speed / 3.0)
	move_and_slide()

func set_kill(focus: Vector2) -> void:
	is_aware = true
	aware_spot = focus
	
func not_kill() -> void:
	is_aware = false
	$Camera2D.zoom = Vector2(1.0, 1.0)
	velocity = Vector2.ZERO

func set_bounds(new_bounds: Vector4) -> void:
	$Camera2D.limit_left = new_bounds[0]
	$Camera2D.limit_top = new_bounds[1]
	$Camera2D.limit_right = new_bounds[2]
	$Camera2D.limit_bottom = new_bounds[3]
