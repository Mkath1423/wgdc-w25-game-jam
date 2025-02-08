extends Node2D

@onready var timer = $Timer
@onready var water_block = $water_block
@onready var ice_block = $IceBlock


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_water_block_block_frozen() -> void:
	ice_block.set_collision_layer_value(1, true)
	print("Ice block collision turned on!")
	timer.start()

func _on_timer_timeout() -> void:
	ice_block.set_collision_layer_value(1, false)
	print("Ice block collision turned off again!")
	timer.stop()
