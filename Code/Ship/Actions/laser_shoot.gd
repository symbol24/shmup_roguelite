class_name LaserShoot extends ProjectileShoot


@onready var length_raycast: RayCast2D = %length_raycast

var laser:Laser = null


func _process(delta: float) -> void:
	if timer_active: _reduce_delay_timer(delta)
	if can_act and shooting and not cycling: _cycle_shoot()
	elif can_act and not shooting and cycling: _release_shoot()
	

func _cycle_shoot() -> void:
	cycling = true
	for point in spawn_points:
		_shoot_one_bullet(point.global_position)


func _release_shoot() -> void:
	remove_child(laser)
	cycling = false
	delay_timer = data.action_delay / (data.proj_attack_speed + ship.data.attack_speed)
	timer_active = true


func _shoot_one_bullet(pos:Vector2) -> void:
	if projectile == null:
		projectile = load(data.projectile_uid)

	if laser == null:
		laser = projectile.instantiate()
		
	add_child(laser)
	if not laser.is_node_ready(): await laser.ready
	laser.setup_attack(data, ship, pos, 0.0)
	length_raycast.target_position.y  = -data.length

	length_raycast.force_raycast_update()
	var new_length:float = data.length
	if length_raycast.is_colliding():
		new_length = global_position.distance_to(length_raycast.get_collider().global_position)
	
	laser.setup_length(new_length)
