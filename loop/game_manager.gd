extends Node2D

@onready var level_manager_packed: PackedScene = preload("res://Levels/level_manager.tscn")
var level_manager
var levels_done = 0
var first_level = 1

func _ready() ->void:
	start_level(first_level)

func begin_landing(level: int) -> void:

func start_level(level: int) -> void:
	level_manager = level_manager_packed.instantiate()
	level_manager.first_level = level
	level_manager.win_level.connect(complete_level)
	add_child(level_manager)

func complete_level(level: int) -> void:
	levels_done = levels_done && level
	level_manager.queue_free()
