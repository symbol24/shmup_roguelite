class_name ProjectileShoot extends ShipAction

@export var spawn_points:Array[Marker2D]

var projectile:PackedScene
var level:Node2D:
	get:
		if level == null: level = get_tree().get_first_node_in_group("level")
		return level
var shooting:bool = false
var cycling:bool = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(data.input_name):
		shooting = true
		get_viewport().set_input_as_handled()
	elif event.is_action_released(data.input_name):
		shooting = false
		get_viewport().set_input_as_handled()


func _process(delta: float) -> void:
	super(delta)
	if can_act and shooting and not cycling: _cycle_shoot()


func _activate(_ship:Ship) -> void:
	ship = _ship
	can_act = true
	delay_timer = 0.0


func _cycle_shoot() -> void:
	if not timer_active:
		delay_timer = data.action_delay / (data.proj_attack_speed + ship.data.attack_speed)
		cycling = true
		for i in data.proj_count_per_attack:
			for point in spawn_points:
				_shoot_one_bullet(point.global_position)
			if data.proj_count_per_attack > 1:
				await get_tree().create_timer(data.delay_between_proj).timeout
		cycling = false
		timer_active = true


func _shoot_one_bullet(pos:Vector2) -> void:
	if projectile == null:
		projectile = load(data.projectile_uid)
	
	var new_proj:Projectile = projectile.instantiate()
	level.add_child(new_proj)
	if not new_proj.is_node_ready(): await new_proj.ready
	new_proj.setup_attack(data, ship, pos, ship.rotation)
	new_proj.name = &"projectile_0"
	new_proj.trigger()


func _reduce_delay_timer(value:float = 0.0) -> void:
	delay_timer -= value
	delay_timer = max(0.0, delay_timer)
	if delay_timer <= 0.0:
		can_act = true
		timer_active = false
	Signals.ActionTimer.emit(data.id, delay_timer, data.action_delay / (data.proj_attack_speed + ship.data.attack_speed))
