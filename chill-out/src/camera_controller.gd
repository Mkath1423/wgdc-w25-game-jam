extends Camera2D

@export var follow_rate : float = 0 
@export var max_follow_distance : float = 0
@export var min_follow_distance : float = 0

var player : Node2D = null

@export var min_pan_distance : float = 0
@export var pan_rate : float = 0
@export var min_pan_rate : float = 0

@export var panning = false
@export var pan_target : Vector2 = Vector2(0, 0)

@export var bounds : Rect2
@export var camera_size : Vector2
signal done_panning

func _ready() -> void:
	initialize()

func initialize():
	var p = get_tree().get_nodes_in_group("player")
	
	if len(p) != 0 and p[0].has_method("get_world_center"):
		player = p[0]
		
	else:
		player = null


func smooth_follow(delta: float):
	if player == null: 
		return
	
	print("following ", player.name)

	var clamped_world_pos = player.get_world_center().clamp(
		bounds.position + 0.5 * camera_size,
		bounds.position + bounds.size - 0.5 * camera_size
	)
	
	var to_player = clamped_world_pos - global_position
	var dist = to_player.length()
	
	if dist < min_follow_distance:
		global_position = clamped_world_pos
		
	else:
		global_position = global_position.lerp(clamped_world_pos, delta*follow_rate)

func start_panning(target: Vector2):
	pan_target = target
	panning = true
	
func pan(delta):
	
	var to_target = pan_target - global_position
	var dist = to_target.length()
	
	if dist < min_follow_distance:
		global_position = pan_target
		panning = false
		done_panning.emit()
	
	else:
		global_position = global_position.lerp(pan_target, delta*pan_rate)
		

func _physics_process(delta: float) -> void:
	if panning:
		pan(delta)
	
	else:
		smooth_follow(delta)
