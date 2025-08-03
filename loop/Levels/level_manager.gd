extends Node2D

@onready var loop_packed: PackedScene = preload("res://Loop/loop_manager.tscn")

@export var first_level: int

var loop
var cur_level_id: int
var cur_level: Level
var result: bool

signal win_level(level_id: int)

func _ready() -> void:
	load_level(first_level)
	
func end_level(win: bool) -> void:
	result = win
	$EndScreenTimer.start()
	
func change_level(new_level: int) -> void:
	cur_level.queue_free()
	loop.queue_free()
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
	loop = loop_packed.instantiate()
	loop.loop_broke.connect(end_level)
	add_child(loop)
	loop.start_loop(cur_level.spawn_point, cur_level.tail_spawn)

func _on_end_screen_timer_timeout() -> void:
	if result:
		win_level.emit(cur_level_id)
	else:
		change_level(cur_level_id)
