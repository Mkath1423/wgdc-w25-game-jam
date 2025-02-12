extends Node2D


@onready var starting_room : Node2D = $Rooms/room_1


var active_room : Node2D = null
var current_spawn_point : Vector2 = Vector2.ZERO

func set_active_room(room: Node2D):
	if room.get_children().size() != 1:
		print("failed to set active room")
		return
	
	active_room = room
	var level = room.get_children()[0]
	
	if level.has_method("get_camera_bounds"):
		$Camera.bounds = level.get_camera_bounds()
	else:
		print("failed to get camera bounds")
	
	
	if level.has_method("get_spawn_point"):
		current_spawn_point = level.get_spawn_point()
	else:
		print("failed to get spawn point")

func _ready() -> void:
	set_active_room(starting_room)
	$player.global_position = current_spawn_point

func _on_killzone_player_died() -> void:
	$player.on_respawn()
	$player.global_position = current_spawn_point
	# reload the room
	active_room.respawn()
