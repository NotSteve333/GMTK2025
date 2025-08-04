extends Creature

var head: LoopHead
var base_eye_pos = Vector2(-10.0, -79.0)
@export var eye_move_dist = 20.0
var eye_dir = Vector2.ZERO

func _ready() -> void:
	my_size = 150.0

func _on_vision_body_entered(body: Node2D) -> void:
	if body is LoopHead and cur_state == State.unaware:
		head = body
		$Vision/VisionTimer.start()
		cur_state = State.suspicious

func _process(delta: float) -> void:
	$Eyes.position = $Eyes.position.move_toward(base_eye_pos + (eye_dir.rotated(-rotation) * eye_move_dist), 2.0)
	match cur_state:
		State.unaware:
			$AnimationPlayer.current_animation = "idle"
			eye_dir = Vector2.ZERO
		State.suspicious:
			$AnimationPlayer.current_animation = "RESET"
			var bodies = $Vision.get_overlapping_bodies()
			if head in bodies:
				eye_dir = (head.position - position).normalized()
			else:
				$Vision/VisionTimer.stop()
				cur_state = State.unaware
		State.aware:
			if !has_emitted:
				aware.emit(position)
				has_emitted = true
func _on_vision_timer_timeout() -> void:
	cur_state = State.aware
