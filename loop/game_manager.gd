extends Node2D

@onready var level_manager_packed: PackedScene = preload("res://Levels/level_manager.tscn")
@onready var landing_scene_packed: PackedScene = preload("res://landing_scene.tscn")
var landing_scene
var level_manager
var levels_done = 0
var first_level = 1

func _ready() ->void:
	begin_landing(first_level)

func begin_landing(level: int) -> void:
	landing_scene = landing_scene_packed.instantiate()
	landing_scene.cur_level = level
	landing_scene.back.connect(complete_level)
	landing_scene.start_level.connect(start_level)
	add_child(landing_scene)

func start_level(level: int) -> void:
	landing_scene.queue_free()
	level_manager = level_manager_packed.instantiate()
	level_manager.first_level = level
	level_manager.win_level.connect(complete_level)
	add_child(level_manager)

func complete_level(level: int) -> void:
	levels_done = levels_done && level
	if level_manager:
		level_manager.queue_free()
	if landing_scene:
		landing_scene.queue_free()
