extends Node2D


@onready var starting_room : Node2D = $Rooms/Level1
var active_room : Node2D = null
var current_spawn_point : Vector2 = Vector2.ZERO

func set_active_room(room):
	$Camera.bounds = room.get_camera_bounds()
	current_spawn_point = room.get_spawn_point()

func _ready() -> void:
	set_active_room(starting_room)

func _on_killzone_player_died() -> void:
	$player.on_respawn()
	$player.global_position = current_spawn_point
	# reload the room
	#get_tree().reload_current_scene()
