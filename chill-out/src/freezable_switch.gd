extends Switch

var is_frozen: bool = false 
var is_active: bool = false

@export var freeze_duration : float = 5

func _ready():
	$freeze_timer.timeout.connect(unfreeze)
	area_entered.connect(_on_area_entered)
	update_sprite()
	

func update_sprite():
	$Sprite2D.frame_coords = Vector2(int(is_active), int(not is_frozen))

func activate():
	if is_frozen:
		return 
	
	is_active = true
	$Sprite2D.frame = 1
	open_gate.emit()
	timer.start(open_duration)
	update_sprite()


func _on_timer_timeout() -> void:
	is_active = false
	$Sprite2D.frame = 0
	close_gate.emit()
	update_sprite()

func _on_area_entered(area: Area2D) -> void:
	if area in get_tree().get_nodes_in_group("projectile"):
		is_frozen = true
		$freeze_timer.start(freeze_duration)
		$Timer.paused = true
		area.collide(self)	
		update_sprite()
		
func unfreeze():
	is_frozen = false
	$Timer.paused = false
	update_sprite()
