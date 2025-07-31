extends Node2D
class_name LoopNode

@export var node_id: int

signal nontrivial_intersect(my_id: int, other_id: int)

func _on_node_area_area_entered(area: Area2D) -> void:
	var node = area.get_parent()
	if node is LoopNode:
		if abs(node_id - node.node_id) > 2:
			nontrivial_intersect.emit(node_id, node.node_id)
