extends Creature

func _process(delta: float) -> void:
	match cur_state:
		State.caught:
			$AnimationTree.current_animation = "scream"
			for i in $Scream.get_overlapping_bodies():
				if i is Creature:
					i.make_aware()
