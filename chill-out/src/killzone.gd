extends Area2D

signal player_died

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_died.emit()
