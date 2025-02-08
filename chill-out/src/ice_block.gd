extends Area2D

@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if get_tree().get_nodes_in_group("projectile"):
		set_collision_layer_value(1, true)
		timer.start()


func _on_timer_timeout() -> void:
	set_collision_layer_value(1, false)
