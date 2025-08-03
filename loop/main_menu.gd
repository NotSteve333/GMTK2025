extends Node2D

@export var completion_state = 0

@export var startup: bool

signal quit()
signal choose_stage(level_id: int)

func _ready() -> void:
	$MainMenuUI.visible = startup
	var planets = $Planets
	for i in planets.get_children():
		if i is Planet:
			i.get_child(0).click_me.connect(select_stage)

func select_stage(level_id: int) -> void:
	if !$MainMenuUI.visible:
		choose_stage.emit(level_id)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		$MainMenuUI.visible = true

func _on_main_menu_ui_play() -> void:
	$MainMenuUI.visible = false

func _on_main_menu_ui_quit() -> void:
	quit.emit()
