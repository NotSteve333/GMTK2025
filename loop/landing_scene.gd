extends Node2D

@export var cur_level: int

signal back(exit_val: int)
signal start_level(this_level: int)

var coming_in: bool = true

func _ready() -> void:
	var planet_name = str("res://Sprites/Intros/Landing", cur_level, ".png")
	var image = Image.load_from_file(planet_name)
	var texture = ImageTexture.create_from_image(image)
	$BG/Planet.texture = texture
	$AnimationPlayer.current_animation = "coming_in"

func bring_up_menu() -> void:
	$LandingMenu.visible = true

func _on_landing_menu_back() -> void:
	back.emit(0)


func _on_landing_menu_deploy() -> void:
	start_level.emit(cur_level)
