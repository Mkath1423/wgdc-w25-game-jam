class_name Switch extends Area2D

signal open_gate
signal close_gate

@export var open_duration : float = 10
@onready var timer = $Timer

func activate():
	$Sprite2D.frame = 1
	open_gate.emit()
	timer.start(open_duration)


func _on_timer_timeout() -> void:
	$Sprite2D.frame = 0
	close_gate.emit()
