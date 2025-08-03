extends Control

signal play()
signal quit()

func _on_play_pressed() -> void:
	play.emit()

func _on_quit_pressed() -> void:
	quit.emit()
