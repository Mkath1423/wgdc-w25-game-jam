class_name Projectile extends Area2D

@export var move_speed : float = 0.0
var move_direction : Vector2 = Vector2(1, 0)

@onready var raycast = $RayCast2D

func on_create(from: Vector2, to: Vector2):
	global_position = from
	move_direction = (to - from).normalized()
	rotate(move_direction.angle())
	#raycast.target_position = move_direction * move_speed *  1/60
	
func _physics_process(delta):
	raycast.force_raycast_update()
		#
	var move_distance : float =  move_speed * delta
	#
	if raycast.is_colliding() and (raycast.get_collision_point() - position).length() < move_distance:
		global_position = raycast.get_collision_point()
		
	else:
		global_position += move_direction * move_distance
	
	for body in get_overlapping_bodies():
		collide(body)


func collide(node):
	print("collided with", node.name)
	if node.is_in_group("player"):
		return
	
	queue_free()
