class_name Projectile extends AttackArea


var direction:Vector2 = Vector2.UP
var life_timer:float = 0.0
var pierce_count:float = 1


func _ready() -> void:
	area_entered.connect(_on_area_entered)
	body_entered.connect(_on_body_entered)


func _physics_process(delta: float) -> void:
	if active:
		if data.proj_type == Enums.Projectile_Type.MOVING:
			global_position += direction * (data.speed + attack_owner.data.projectile_speed) * delta
			if global_position.distance_squared_to(origin) >= data.life_time_distance:
				destroy_self()
		elif data.proj_type == Enums.Projectile_Type.FIXED:
			if data.projectile_life_time > 0.0: 
				life_timer -= delta
				if life_timer <= 0.0:
					destroy_self()


func setup_attack(_data:ActionData, _owner:Node2D, pos:Vector2 = Vector2.ZERO, rot:float = 0.0) -> void:
	data = _data
	attack_owner = _owner
	if pos != Vector2.ZERO:
		global_position = pos
		origin = pos
	scale *= 1 + data.proj_projectile_size + attack_owner.data.projectile_size if attack_owner is Ship else 1
	rotation = rot
	direction = direction.rotated(rotation)
	life_timer = data.projectile_life_time
	pierce_count = data.proj_pierce_count + attack_owner.data.projectile_peirce_count if attack_owner is Ship else data.proj_pierce_count


func get_damage() -> Damage:
	var damage:Damage = Damage.new()
	var cc_check:float = randf()
	var cc:float = data.proj_crit_chance + attack_owner.data.crit_chance
	if cc_check <= cc:
		damage.is_critical = true
	var cd:float = 1.0 + data.proj_crit_damage + attack_owner.data.crit_damage if damage.is_critical else 1.0
	damage.value = (data.proj_damage + attack_owner.data.damage) * cd
	damage.type = data.proj_damage_type
	damage.sub_types = data.proj_sub_damage_types.duplicate(true)
	return damage


func _on_area_entered(_area:Area2D) -> void:
	pass
	

func _on_body_entered(_body:Node2D) -> void:
	if not _body is Target:
		destroy_self()
