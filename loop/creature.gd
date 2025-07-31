extends CharacterBody2D
class_name Creature

signal aware()

var cur_state: State = State.unaware

enum State {
	unaware,
	suspicious,
	aware,
	caught
}
	
