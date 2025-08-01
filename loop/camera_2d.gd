extends CharacterBody2D

var direction: Vector2
var speed: float

func _process(delta: float) -> void:
	var y_dir = Input.get_axis("up", "down")
	var x_dir = Input.get_axis("left", "right")
	direction = Vector2(x_dir, y_dir).normalized()

func _physics_process(delta: float) -> void:
	velocity = velocity.move_toward(direction * speed, speed / 4.0)
	move_and_slide()
