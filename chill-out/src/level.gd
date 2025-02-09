class_name Level extends Node2D

@export var spawn_point: Vector2 = Vector2(0, 0)

func get_camera_bounds() -> Rect2:
	return Rect2($CameraBounds.global_position - $CameraBounds.shape.size, 2*$CameraBounds.shape.size)

func get_spawn_point():
	return spawn_point
