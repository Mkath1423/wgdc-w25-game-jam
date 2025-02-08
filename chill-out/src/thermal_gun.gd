extends Node2D

@export var max_capacity : int = 0
var loaded_shots : Array[PackedScene] = []

func can_load(): 
	return loaded_shots.size() < max_capacity

func load(ammo: PackedScene):
	loaded_shots.append(ammo)
	
func fire(from: Vector2, to: Vector2):
	if loaded_shots.size() == 0:
		return 
		
	var bullet = loaded_shots.pop_front().instantiate()
	get_tree().root.add_child(bullet)
	if bullet.has_method("on_create"):
		bullet.on_create(from, to)
