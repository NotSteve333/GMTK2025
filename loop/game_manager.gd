extends Node2D

@onready var level_manager_packed: PackedScene = preload("res://Levels/level_manager.tscn")
@onready var landing_scene_packed: PackedScene = preload("res://landing_scene.tscn")
@onready var menu_scene_packed: PackedScene = preload("res://main_menu.tscn")
@onready var win_scene_packed: PackedScene = preload("res://win_screen.tscn")
var landing_scene
var menu_scene
var win_scene
var level_manager
var levels_done = 0
var first_level = 1

func _ready() ->void:
	print("READY:", get_script().resource_path)
	show_menu(true, levels_done)
	
func show_menu(startup: bool, game_state: int) -> void:
	menu_scene = menu_scene_packed.instantiate()
	menu_scene.startup = startup
	menu_scene.completion_state = game_state
	menu_scene.quit.connect(quit)
	menu_scene.choose_stage.connect(begin_landing)
	add_child(menu_scene)
		
func quit() -> void:
	get_tree().quit()
	
func show_win() -> void:
	win_scene = win_scene_packed.instantiate()
	add_child(win_scene)

func begin_landing(level: int) -> void:
	menu_scene.queue_free()
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
	levels_done = levels_done + level
	if level_manager:
		level_manager.queue_free()
	if landing_scene:
		landing_scene.queue_free()
	if levels_done == 7:
		show_win()
	else:
		show_menu(false, levels_done)
