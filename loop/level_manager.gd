extends Node2D
class_name Level

func _ready() -> void:
	for i in $Creatures.get_children():
		if i is Creature:
			i.aware.connect(game_over)

func game_over() -> void:
	print("game over")
