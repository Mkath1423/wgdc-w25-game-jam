extends Node2D

@export var total_ammo : int = 0
@export var infinite_ammo : bool = false


@export var ammo : PackedScene = null

func can_take(n: int):
	return total_ammo >= n or infinite_ammo
	
func take_ammo():
	if not infinite_ammo:
		total_ammo -= 1
	return ammo 
