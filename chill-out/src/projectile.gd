class_name Projectile extends Node2D

@export var move_speed : float = 0.0
var move_direction : Vector2 = Vector2(1, 1)

@onready var raycast = $RayCast2D

func on_create(from: Vector2, to: Vector2):
	global_position = from
	move_direction = (to - from).normalized()
	#rotate(move_direction.angle())
	#raycast.target_position = move_direction * move_speed *  1/60
	
func _physics_process(delta):
	#raycast.force_raycast_update()
	#
	#if raycast.is_colliding():
		#global_position = raycast.get_collision_point()
		#print("AGHHH")
		#
	#else:
	global_position += move_direction * move_speed * delta
	
