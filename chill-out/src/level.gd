class_name Level extends Node2D


func _ready():
	$Area2D.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().get_root().get_child(0).set_active_room(get_parent())



func get_camera_bounds() -> Rect2:
	return Rect2($Area2D/CameraBounds.global_position - $Area2D/CameraBounds.shape.size, 2*$Area2D/CameraBounds.shape.size)

func get_spawn_point():
	return $SpawnPoint.global_position
