class_name PelletShipMove extends BasicMove


var boosting:bool = false
var last_direction:Vector2 = Vector2.ZERO

func _ready() -> void:
	super()
	Signals.ActionToggled.connect(_toggle_boost)


func _physics_process(delta: float) -> void:
	if can_act:
		direction = Input.get_vector("left", "right", "up", "down")
<<<<<<< HEAD
=======
		var target_angle:float = Vector2.RIGHT.angle_to(last_direction)
		ship.rotation = lerp_angle(ship.rotation, target_angle, delta * 10)
>>>>>>> symbol/twinstick_commit
		var boost:float = data.boost_multiplyer if boosting else 1.0
		ship.apply_central_force(direction * ship.data.speed * boost)
		ship.linear_velocity.x = clampf(ship.linear_velocity.x, -(ship.data.speed/2) * boost, (ship.data.speed/2) * boost)
		ship.linear_velocity.y = clampf(ship.linear_velocity.y, -(ship.data.speed/2) * boost, (ship.data.speed/2) * boost)
		if direction != Vector2.ZERO: last_direction = direction


func _toggle_boost(action_id:StringName, toggle:bool) -> void:
	if action_id == data.id:
		boosting = toggle