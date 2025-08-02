extends CharacterBody2D
class_name LoopHead

@export var base_speed = 300.0
@export var dash_speed = 200.0
var is_stopped = false
var direction = Vector2.ZERO
var dist: float
@export var last_node: Vector2
var num_nodes: int = 0
@export var spawn_dist = 100.0
var mouse_pos: Vector2


func _process(delta: float) -> void:
	if !is_stopped:
		mouse_pos = get_global_mouse_position()
		
		var diff = mouse_pos - position
		direction = diff.normalized()
		dist = diff.length()

func _physics_process(delta: float) -> void:
	var cur_speed = base_speed + (dash_speed * min(1.0, dist / 200.0))
	
	if !is_stopped:
		velocity = velocity.move_toward(direction * cur_speed, base_speed / 20.0)
		move_and_slide()
