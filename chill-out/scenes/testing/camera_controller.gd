extends Node2D

@export var scroll_speed : float = 0
@export var follow_rate : float = 0 
@export var max_follow_distance : float = 0
@export var min_follow_distance : float = 0

var player : Node2D = null

@export var min_pan_distance : float = 0
@export var pan_rate : float = 0
@export var min_pan_rate : float = 0

@export var panning = false
@export var pan_target : Vector2 = Vector2(0, 0)

signal done_panning

func _ready() -> void:
	initialize()

func initialize():
	var p = get_tree().get_nodes_in_group("player")
	if len(p) == 0:
		player = null
		
	else:
		player = p[0]


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
		global_position = global_position.lerp(player.global_position, clamp(delta*follow_rate, min_pan_rate, 1))

func start_panning(target: Vector2):
	pan_target = target
	panning = true
	
func pan(delta):
	
	var to_target = pan_target - global_position
	var dist = to_target.length()
	
	if dist < min_follow_distance:
		position = pan_target
		panning = false
		done_panning.emit()
	
	else:
		global_position = global_position.lerp(pan_target, delta*pan_rate)
		

func _physics_process(delta: float) -> void:
	if panning:
		pan(delta)
	
	else:
		smooth_follow(delta)
