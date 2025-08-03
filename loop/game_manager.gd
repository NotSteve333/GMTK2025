extends Node2D

@onready var level_manager_packed: PackedScene = preload("res://Levels/level_manager.tscn")
var level_manager

func start_level(level: int) -> void:
	level_manager = level_manager.instantiate()
