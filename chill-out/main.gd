extends Node2D


@onready var starting_room : Node2D = $Rooms/Level1
var active_room : Node2D = null

func set_active_room(room):
	$Camera.bounds = room.get_camera_bounds()

func _ready() -> void:
	set_active_room(starting_room)

func _on_killzone_player_died() -> void:
	pass
	# do whatever is needed to do to respawn.
