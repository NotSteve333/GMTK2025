extends CharacterBody2D

@export var cam_speed: float = 250.0

var direction: Vector2

func _process(delta: float) -> void:
	var y_dir = Input.get_axis("up", "down")
	var x_dir = Input.get_axis("left", "right")
	direction = Vector2(x_dir, y_dir).normalized()

func _physics_process(delta: float) -> void:
	velocity = velocity.move_toward(direction * cam_speed, cam_speed / 4.0)
	move_and_slide()

func set_bounds(new_bounds: Vector4) -> void:
	$Camera2D.limit_left = new_bounds[0]
	$Camera2D.limit_top = new_bounds[1]
	$Camera2D.limit_right = new_bounds[2]
	$Camera2D.limit_bottom = new_bounds[3]
