class_name FreezeCrystalAmmoPickup extends ReloadPickup


func take(n):
	$Sprite2D.hide()
	$RefreshTimer.start()
	$CollisionShape2D.disabled = true
	return super(n)

func on_refresh_timeout():
	ammo_left = max_capacity
	$CollisionShape2D.disabled = false
	$Sprite2D.show()
