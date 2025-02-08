extends Node2D


@onready var starting_room : Node2D = $Rooms/Level0
var active_room : Node2D = null

func set_active_room(room):
	$Camera.bounds = room.get_camera_bounds()

func _ready() -> void:
	print($Rooms/Level0)
	set_active_room(starting_room)


func _on_killzone_player_died() -> void:
	get_tree().reload_current_scene()
