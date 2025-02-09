extends Area2D

signal open_gate
signal close_gate

@onready var timer = $Timer

func activate():
	open_gate.emit()
	timer.start()


func _on_timer_timeout() -> void:
	close_gate.emit()
