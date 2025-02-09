class_name ReloadPickup extends Node2D

@export var max_capacity : int = 0
@export var is_infinite  : bool = false

@export var projectile : PackedScene = null

@onready var ammo_left : int = max_capacity

func can_take(n):
	return ammo_left >= n or is_infinite 

func take_ammo():
	ammo_left = max(ammo_left, 0)
	return projectile
