extends Area2D
class_name Clickable

@export var planet_id: int

var can_click_me: bool
var time_elapsed = 0.0

signal click_me(id: int)

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		click_me.emit(planet_id)

func _on_mouse_enter() -> void:
	can_click_me = true

func _on_mouse_exit() -> void:
	can_click_me = false
