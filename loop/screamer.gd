extends Creature

func _process(delta: float) -> void:
	match cur_state:
		State.caught:
			$AnimationTree.current_animation = "scream"
