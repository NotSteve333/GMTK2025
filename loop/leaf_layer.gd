extends Sprite2D
class_name LeafLayer

@export var max_drift = 7.0
var base_pos: Vector2
var reduce: float = 1.0

func _ready() -> void:
	base_pos = position

func nudge(wind: Vector2, dev: float) -> void:
	var my_dev = Vector2(randfn(0.0, dev / reduce), randfn(0.0, dev / reduce))
	var nudge_vec = wind + my_dev
	var new_pos = position + nudge_vec
	var diff = new_pos - base_pos
	if diff.length() > max_drift:
		new_pos = diff.normalized() * max_drift
	position = position.move_toward(new_pos, dev)
