extends CharacterBody2D
class_name LoopHead

@export var base_speed = 300.0
@export var dash_speed = 200.0
var children: Array
var direction = Vector2.ZERO
var dist: float
var last_node: Vector2
var num_nodes: int = 0
@export var spawn_dist = 100.0
var is_dash = false
var mouse_pos: Vector2


func _process(delta: float) -> void:
	#var y_dir = Input.get_axis("up", "down")
	#var x_dir = Input.get_axis("left", "right")
	#direction = Vector2(x_dir, y_dir).normalized()
	
	mouse_pos = get_global_mouse_position()
	
	var diff = mouse_pos - position
	direction = diff.normalized()
	dist = diff.length()
	
	if !is_dash and Input.is_action_pressed("dash"):
		is_dash = true
		$DashTimer.start()

func _physics_process(delta: float) -> void:
	var cur_speed = base_speed + (dash_speed * min(1.0, dist / 200.0))
	
	velocity = velocity.move_toward(direction * cur_speed, base_speed / 20.0)
	
	move_and_slide()

func _on_dash_timer_timeout() -> void:
	is_dash = false
