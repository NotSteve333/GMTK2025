extends Node2D
class_name Level

@export var level_id: int
@export var cam_bounds: Vector4
@export var spawn_point: Vector2
@export var tail_spawn: Vector2
var catches: int = 0
var num_creatures: int = 0

signal end_level(win: bool)

func _ready() -> void:
	num_creatures = $Creatures.get_child_count()
	for i in range(num_creatures):
		var guy = $Creatures.get_child(i)
		if guy is Creature:
			guy.aware.connect(game_over)
			guy.im_caught.connect(update_catches)

func update_catches() -> void:
	catches += 1
	if catches == num_creatures:
		print("you win")
		end_level.emit(true)

func game_over(location: Vector2) -> void:
	print("game over")
	end_level.emit(false)

func _on_loop_manager_caught_creature(creature: Creature, center: Vector2) -> void:
	creature.caught(center)
