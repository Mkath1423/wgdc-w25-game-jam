extends CharacterBody2D

@export var scroll_speed : float = 0
@export var follow_rate : float = 0 
@export var min_follow_rate : float = 0
@export var max_follow_distance : float = 0
@export var min_follow_distance : float = 0

var player : Node2D = null

@export var min_pan_distance : float = 0
@export var pan_rate : float = 0
@export var min_pan_rate : float = 0

@export var panning = false
@export var pan_target : Vector2 = Vector2(0, 0)

var clamping_enabled : bool = false

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
	
	var collision : KinematicCollision2D = move_and_collide(to_player)
	
	if collision:
		print(to_player, collision.get_travel())
		to_player = collision.get_travel()
		print("detected collision at ", collision.get_position())
		
	
	var dist = to_player.length()
	
	if dist < min_follow_distance:
		return
		velocity = to_player
		print("jumping ", velocity)
		
	elif dist > max_follow_distance:
		velocity = ((dist - max_follow_distance)/dist) * to_player
	
	else:
		print(delta * follow_rate)
		velocity = to_player * clamp(delta*follow_rate, 0, 1)
		print("following ", velocity)
	
	move_and_slide()
	velocity = Vector2(0, 0)
func start_panning(target: Vector2):
	$CollisionShape2D.disabled = true
	pan_target = target
	panning = true
	
func pan(delta):
	
	var to_target = pan_target - global_position
	var dist = to_target.length()
	
	if dist < min_follow_distance:
		global_position = pan_target
		panning = false
		$CollisionShape2D.disabled = false
		done_panning.emit()
	
	else:
		global_position = global_position.lerp(pan_target, delta*pan_rate)

func _physics_process(delta: float) -> void:
	if panning:
		pan(delta)
	
	else:
		smooth_follow(delta)
