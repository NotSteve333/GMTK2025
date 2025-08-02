extends Node2D

@onready var trail_interior := $LoopInterior
@onready var trail_border:= $LoopBorder
@onready var node_scenes: PackedScene = preload("res://Loop/loop_node.tscn")
@onready var head: LoopHead = $LoopHead

@export var enabled = false
@export var max_pull_speed = 500.0

var trail_points: PackedVector2Array = []
var num_nodes = 0
var nodes = []
var active_inter: IntersectData
var max_nodes = 500
var delete_threshold = 15.0

class IntersectData:
	var finished: bool
	var bounds: Vector2
	var center: Vector2
	var cleanup: int

func start_loop(spawn: Vector2, tail_spawn: Vector2) -> void:
	$LoopHead.position = spawn
	$LoopHead.last_node = spawn
	add_loop_points(tail_spawn)
	add_loop_points(spawn)
	enabled = true
	$LoopHead.is_stopped = false

func _process(_delta):
	if enabled:
		var head_pos = $LoopHead.position
		
		if !head.is_stopped and ((trail_interior.get_point_count() < 1) or head_pos.distance_to(trail_interior.get_point_position(min(num_nodes, max_nodes)-1)) > 7.0):
			add_loop_points(head_pos)
		
func _physics_process(delta: float) -> void:
	if enabled:
		if active_inter:
			pull_in(active_inter, delta)

func recieve_intersect(first_id: int, second_id: int, center: Vector2) -> void:
	if enabled and (active_inter == null or active_inter.finished == true):
		head.is_stopped = true
		var pair: Vector2 = Vector2(min(first_id, second_id), max(first_id, second_id))
		$LoopClose/CollisionPolygon2D.polygon = trail_interior.points.slice(pair.x, pair.y)
		active_inter = IntersectData.new()
		active_inter.finished = false
		active_inter.bounds = pair
		active_inter.center = center
		active_inter.cleanup = 0
		
func remove_loop_points(index: int) -> void:
	num_nodes -= 1
	trail_border.remove_point(index)
	trail_interior.remove_point(index)
	$LoopNodes.get_child(index).queue_free()
	
func add_loop_points(pos: Vector2) -> void:
	num_nodes += 1
	trail_interior.add_point(pos)
	trail_border.add_point(pos)
	var new_node = node_scenes.instantiate()
	new_node.nontrivial_intersect.connect(recieve_intersect)
	new_node.node_id = num_nodes
	new_node.global_position = pos
	$LoopNodes.add_child(new_node)
	
func pull_in(inter: IntersectData, delta: float) -> void:
	if inter.cleanup >= abs(inter.bounds.x - inter.bounds.y + 1):
		inter.finished = true
		head.is_stopped = false
		return
	for i in range(inter.bounds.x - 1, inter.bounds.y - inter.cleanup):
		var point_diff = inter.center - trail_border.get_point_position(i)
		var diff_m = point_diff.length()
		if diff_m < 20.0:
			remove_loop_points(i)
			inter.cleanup += 1
			i -= 1
		else:
			trail_border.set_point_position(i, trail_border.get_point_position(i).move_toward(inter.center, delta * min(diff_m, max_pull_speed)))
			trail_interior.set_point_position(i, trail_border.get_point_position(i))

func clear_loop() -> void:
	enabled = false
	$LoopHead.is_stopped = true
	for i in range(num_nodes):
		remove_loop_points(i)

func _on_loop_close_body_entered(body: Node2D) -> void:
	if body is Creature:
		body.caught()
