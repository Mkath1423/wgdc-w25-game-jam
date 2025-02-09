extends Node2D

@onready var gate_door = $"Gate Door"

func _on_switch_open_gate() -> void:
	gate_door.hide()
	gate_door.set_collision_layer_value(1, false)

func _on_switch_close_gate() -> void:
	gate_door.show()
	gate_door.set_collision_layer_value(1, true)
