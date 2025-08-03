extends Control

signal back_to_game()
signal quit()

func _on_back_to_game_pressed() -> void:
	back_to_game.emit()


func _on_main_menu_pressed() -> void:
	quit.emit()
