extends Node2D

var cur_level: Level

func _ready() -> void:
	for i in $Creatures.get_children():
		if i is Creature:
			i.aware.connect(game_over)

func game_over() -> void:
	print("game over")

func _on_loop_manager_caught_creature(creature: Creature, center: Vector2) -> void:
	creature.caught(center)
