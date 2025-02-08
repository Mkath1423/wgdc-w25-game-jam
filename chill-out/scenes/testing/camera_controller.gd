extends Node2D

@export var scroll_speed : float = 0
@export var follow_rate : float = 0 
@export var max_follow_distance : float = 0
@export var min_follow_distance : float = 0

var player : Node2D = null

var panning = false

signal done_panning

func _ready() -> void:
	initialize()

func initialize():
	var p = get_tree().get_nodes_in_group("player")
	if len(p) == 0:
		player = null
		
	else:
		player = p[0]

func update_camera_position():
	pass

func smooth_follow(delta: float):
	if player == null: 
		return
		
	var to_player = player.global_position - global_position
	var dist = to_player.length()
	
	if dist < min_follow_distance:
		position += to_player
		
	elif dist > max_follow_distance:
		position += ((dist - max_follow_distance)/dist) * to_player
	
	else:
		global_position = global_position.lerp(player.global_position, delta*follow_rate)

func _physics_process(delta: float) -> void:
	if panning:
		pass
	
	else:
		smooth_follow(delta)
