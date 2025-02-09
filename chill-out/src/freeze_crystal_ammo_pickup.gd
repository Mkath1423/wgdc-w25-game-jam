class_name FreezeCrystalAmmoPickup extends ReloadPickup


func take_ammo():
	$Sprite2D.hide()
	$RefreshTimer.start()
	set_collision_layer_value(1, false)
	return super()

func on_refresh_timeout():
	ammo_left = max_capacity
	set_collision_layer_value(1, true)
	$Sprite2D.show()
	print("refreshed crystal", ammo_left)
