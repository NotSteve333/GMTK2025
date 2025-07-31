extends Node2D

@onready var trail_interior := $LoopInterior
@onready var trail_border:= $LoopBorder
@onready var node_scenes: PackedScene = preload("res://loop_node.tscn")
var trail_points: PackedVector2Array = []
var num_nodes = 0
var max_nodes = 500

func _process(delta):
	var head_pos = $LoopHead.position
	
	if (trail_interior.get_point_count() < 1) or head_pos.distance_to(trail_interior.get_point_position(min(num_nodes, max_nodes)-1)) > 20.0:
		num_nodes += 1
		trail_interior.add_point(head_pos)
		trail_border.add_point(head_pos)
		var new_node = node_scenes.instantiate()
		new_node.nontrivial_intersect.connect(recieve_intersect)
		new_node.node_id = num_nodes
		new_node.global_position = head_pos
		$LoopNodes.add_child(new_node)
		if trail_interior.get_point_count() > max_nodes:
			trail_interior.remove_point(0)
			trail_border.remove_point(0)
	
func recieve_intersect(first_id: int, second_id: int) -> void:
	$LoopClose/CollisionPolygon2D.polygon = trail_interior.points.slice(min(first_id, second_id), max(first_id, second_id))
	
func _on_loop_close_body_entered(body: Node2D) -> void:
	if body is Creature:
		print("caught creature")
