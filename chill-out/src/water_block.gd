extends Area2D

signal block_frozen

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	print("Water block body entered!")
	if body in get_tree().get_nodes_in_group("projectile"):
		block_frozen.emit()
