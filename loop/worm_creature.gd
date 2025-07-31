extends Creature

@onready var vision: ShapeCast2D = $RayCast2D

func _ready() -> void:
	$AnimationPlayer.current_animation = "rotate"
	$RayCast2D.collide_with_areas = false
	
func check_collisions() -> bool:
	var collisions = vision.collision_result
	for i in collisions:
		if i is LoopHead:
			print("hit")
			return true
	return false

func _process(delta: float) -> void:
	match cur_state:
		State.unaware:
			$AnimationPlayer.speed_scale = 1.0
			if check_collisions():
				cur_state = State.suspicious
				$SusTimer.start()
		State.suspicious:
			$AnimationPlayer.speed_scale = 0.0
		State.aware:
			aware.emit()
			

func _on_sus_timer_timeout() -> void:
	print("timeout")
	if check_collisions():
		cur_state = State.aware
	else:
		cur_state = State.unaware
