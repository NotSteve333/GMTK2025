extends Creature

@onready var vision: ShapeCast2D = $ShapeCast2D

func _ready() -> void:
	$AnimationPlayer.current_animation = "rotate"
	vision.collide_with_areas = false
	my_size = 50.0
	
func check_collisions() -> bool:
	var collisions = vision.collision_result
	for i in range(collisions.size()):
		if $ShapeCast2D.get_collider(i) is LoopHead:
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
			aware.emit(global_position)
		State.caught:
			$AnimationPlayer.current_animation = "caught"
			

func _on_sus_timer_timeout() -> void:
	if check_collisions():
		cur_state = State.aware
	else:
		cur_state = State.unaware
