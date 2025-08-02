extends Node2D

@export var first_level = 1
var cur_level_id: int
var cur_level: Level

func _ready() -> void:
	load_level(first_level)
	
func end_level(win: bool) -> void:
	$LoopManager.clear_loop()
	change_level(cur_level_id + int(win))
	
func change_level(new_level: int) -> void:
	cur_level.queue_free()
	load_level(new_level)
	
func load_level(level_id: int) -> void:
	cur_level_id = level_id
	var pathname = str("res://Levels/LevelScenes/level_", level_id, ".tscn")
	var pre_scene = load(pathname)
	cur_level = pre_scene.instantiate()
	cur_level.end_level.connect(end_level)
	$CameraController.set_bounds(cur_level.cam_bounds)
	add_child(cur_level)
	$CameraController.position = cur_level.spawn_point + Vector2(576, 0)
	$LoopManager.start_loop(cur_level.spawn_point, cur_level.tail_spawn)
