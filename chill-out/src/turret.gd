extends StaticBody2D

@export var shoot_delay : float
@export var projectile: PackedScene

func _ready():
	$shoot_timer.timeout.connect(fire)
	$reload_timer.timeout.connect(reload)
	
	$unloaded.show()
	$loaded.hide()
	
	$shoot_timer.start(shoot_delay)
	$reload_timer.start(shoot_delay*0.75)
	
	
func reload():
	$unloaded.hide()
	$loaded.show()
	
func fire():
	$unloaded.show()
	$loaded.hide()
	var p = projectile.instantiate()
	get_tree().root.add_child(p)
	if p.has_method("on_create"):
		p.on_create(to_global(Vector2(0, -4)), to_global(Vector2(0, -8)))
	
