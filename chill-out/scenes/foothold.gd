extends Node2D


func _ready():
	$Area2D.body_entered.connect(on_collision_enter)
	$BreakTimer.timeout.connect(on_break_timeout)

var tracked_bodies : Array[CharacterBody2D] = []

func on_collision_enter(body):
	print("collision")
	if body.is_in_group("player") and not tracked_bodies.has(body):
		tracked_bodies.append(body)

func on_collision_exit(body):
	tracked_bodies.erase(body)
	
func _physics_process(delta):
	var to_remove = []
	for body in tracked_bodies:
		print("checking: ", body.name)
		if abs(body.velocity.y) < 0.01:
			$BreakTimer.start()
			to_remove.append(body)
	
	for body in to_remove:
		tracked_bodies.erase(body)
		
	
func on_break_timeout():
	$Sprite2D.hide()	
	$StaticBody2D/CollisionShape2D.disabled = true
	$Area2D/CollisionShape2D.disabled = true
