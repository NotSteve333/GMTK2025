extends CharacterBody2D
class_name Creature

signal aware(my_location: Vector2)
signal im_caught()

var pull_center: Vector2
@export var my_size: float
var creature_id: int
var has_emitted = false
var has_caught = false
@export var cur_state: State = State.unaware

enum State {
	unaware,
	suspicious,
	aware,
	caught
}

func make_aware() -> void:
	cur_state = State.aware

func _physics_process(delta: float) -> void:
	if cur_state == State.caught:
		if !has_caught:
			has_caught = true
			im_caught.emit()
		var diff = pull_center - position
		var diff_m = diff.length()
		if diff_m < my_size:
			queue_free()
		velocity = min(500.0, diff_m) * diff.normalized()
		move_and_slide()

func caught(center: Vector2) -> void:
	cur_state = State.caught
	pull_center = center
