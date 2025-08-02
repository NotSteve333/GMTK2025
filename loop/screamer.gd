extends Creature

func caught(center: Vector2) -> void:
	cur_state = State.caught
	pull_center = center
	print("deebo")
