extends CharacterBody2D
class_name Planet

@export var planet_id: int

var can_click_me: bool
var time_elapsed = 0.0

signal click_me(id: int)

func _physics_process(delta: float) -> void:
	time_elapsed += delta
	velocity = velocity.move_toward(30.0 * Vector2(sin(time_elapsed + planet_id), cos(time_elapsed + planet_id)), 20.0)
	move_and_slide()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click") and can_click_me:
		click_me.emit(planet_id)

func _on_mouse_enter() -> void:
	can_click_me = true

func _on_mouse_exit() -> void:
	can_click_me = false
