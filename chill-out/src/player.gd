class_name Player extends CharacterBody2D

@export var ground_move_speed = 0
@export var air_move_speed = 0


@export var jump_speed = 0

@export var max_fall_speed = 0

@export var coyote_frames = 0
var was_grounded = 0

@export var jump_buffering_frames = 0
var was_jumping = 0

@export var variable_jump_stopping = 1

@export var additional_fall_gravity_threshhold : float = 0.0
@export var additional_fall_gravity : float = 0

@export var apex_move_speed_bonus = 0
@export var apex_boost_threshhold = 0

var jumping : bool = false

func get_world_center():
	return $Sprite2D.global_position

func check_grounded():
	# grounding
	if is_on_floor():
		was_grounded = coyote_frames
		jumping = false
	else:
		was_grounded -= 1

func check_for_jump_input():
	# jump buffering
	if Input.is_action_just_pressed("jump"):
		was_jumping = jump_buffering_frames
		
	elif Input.is_action_just_released("jump"):
		was_jumping = 0

	else:
		was_jumping -= 1

func check_for_jump_cancel():
	if not jumping:
		return
		
	# variable jumps
	if Input.is_action_just_released("jump") and get_last_motion().y < 0:
		velocity.y = velocity.y / variable_jump_stopping
		jumping = false

func do_jump():
	velocity.y = -jump_speed
	jumping = true

func strafing(): 
	var speed = 0
	if is_on_floor():
		speed = ground_move_speed
	else:
		speed = air_move_speed
	
	# apex boost
	if jumping and not is_on_floor() and abs(get_last_motion().y) < apex_boost_threshhold:
		speed += apex_move_speed_bonus

	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

func clamp_falling():
	# fall velocity clamp
	if velocity.y > max_fall_speed:
		velocity.y = max_fall_speed

func _process(delta):
	if Input.is_action_just_pressed("fire"):
		$ThermalGun.fire(
			global_position,
			get_global_mouse_position()
		)
		
	if Input.is_action_just_pressed("pickup"):
		for area in $pickup_range.get_overlapping_areas():
			if area.has_method("can_take") and \
				area.can_take(1) and \
				$ThermalGun.can_load(1):
				$ThermalGun.load(area.take(1))
	
	if Input.is_action_just_pressed("pickup"):
		print("flipping switch")
		for area in $pickup_range.get_overlapping_areas():
			if area.has_method("activate"):
				print("activing", area.name)
				area.activate()

func _physics_process(delta):
	# gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	
	if get_last_motion().y < additional_fall_gravity_threshhold:
		velocity += get_gravity() * additional_fall_gravity * delta

	check_grounded()
	check_for_jump_input() # jump buffering
	
	# handle jump
	if was_jumping > 0 and was_grounded > 0:
		do_jump()

	check_for_jump_cancel()
	
	strafing()
	clamp_falling()

	move_and_slide()
	
func on_respawn():
	$ThermalGun.unload()
