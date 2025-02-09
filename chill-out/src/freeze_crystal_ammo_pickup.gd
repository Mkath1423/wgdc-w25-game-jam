class_name FreezeCrystalAmmoPickup extends ReloadPickup


func take_ammo():
	$Sprite2D.hide()
	$RefreshTimer.start()
	$CollisionShape2D.disabled = true
	return super()

func on_refresh_timeout():
	ammo_left = max_capacity
	$CollisionShape2D.disabled = false
	$Sprite2D.show()
