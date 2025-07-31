extends CharacterBody2D
class_name LoopHead

@export var base_speed = 500.0
@export var dash_speed = 800.0
var direction = Vector2.ZERO

var is_dash = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	var y_dir = Input.get_axis("up", "down")
	var x_dir = Input.get_axis("left", "right")
	direction = Vector2(x_dir, y_dir).normalized()
	
	if !is_dash and Input.is_action_pressed("dash"):
		print("dashaaaa")
		is_dash = true
		$DashTimer.start()

func _physics_process(delta: float) -> void:
	var cur_speed = base_speed + (dash_speed * int(is_dash))
	print(cur_speed)
	
	velocity = velocity.move_toward(direction * cur_speed, base_speed / 50.0)
	
	move_and_slide()
	


func _on_dash_timer_timeout() -> void:
	is_dash = false
