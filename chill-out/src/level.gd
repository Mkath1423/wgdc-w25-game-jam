class_name Level extends Node2D

func get_camera_bounds() -> Rect2:
	return Rect2($CameraBounds.global_position - $CameraBounds.shape.size, 2*$CameraBounds.shape.size)
