class_name Level extends Node2D

signal player_enter()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_enter.emit(self)


func get_camera_bounds() -> Rect2:
	return Rect2($Area2D/CameraBounds.global_position - $Area2D/CameraBounds.shape.size, 2*$Area2D/CameraBounds.shape.size)

func get_spawn_point():
	return $SpawnPoint.global_position
