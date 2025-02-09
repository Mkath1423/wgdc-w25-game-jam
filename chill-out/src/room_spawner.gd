class_name room_spawner extends Node2D

@export var room : PackedScene

func respawn():
	for child in get_children():
		remove_child(child)
		child.queue_free()
		
	add_child(room.instantiate())
