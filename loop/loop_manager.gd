extends Node2D

@onready var trail_interior := $LoopInterior
@onready var trail_border:= $LoopBorder
@onready var node_scenes: PackedScene = preload("res://loop_node.tscn")
var trail_points: PackedVector2Array = []
var num_nodes = 0
var max_nodes = 500

func _process(delta):
	var head_pos = $LoopHead.global_position
	if trail_points.is_empty() or head_pos.distance_to(trail_points[-1]) > 20.0:
		num_nodes += 1
		trail_points.append(head_pos)
		var new_node = node_scenes.instantiate()
		new_node.nontrivial_intersect.connect(recieve_intersect)
		new_node.node_id = num_nodes
		new_node.global_position = head_pos
		$LoopNodes.add_child(new_node)
		if trail_points.size() > max_nodes:
			trail_points.remove_at(0)

	trail_interior.points = trail_points
	trail_border.points = trail_points
	
func recieve_intersect(first_id: int, second_id: int) -> void:
	pass
	
	
