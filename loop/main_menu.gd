extends Node2D

signal quit()
signal choose_stage(level_id: int)

func _ready() -> void:
	var planets = $Planets
	for i in planets.get_children():
		if i is Planet:
			i.click_me.connect(select_stage)
			
func select_stage(level_id: int) -> void:
	choose_stage.emit(level_id)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		pass
