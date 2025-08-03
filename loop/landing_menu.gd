extends Control

signal deploy()
signal back()

func _on_deploy_pressed() -> void:
	deploy.emit()

func _on_back_pressed() -> void:
	back.emit()
