class_name PelletShipMove extends BasicMove


var boosting:bool = false


func _ready() -> void:
	super()
	Signals.ActionToggled.connect(_toggle_boost)


func _physics_process(_delta: float) -> void:
	if can_act:
		direction = Input.get_vector("left", "right", "up", "down")
		var boost:float = data.boost_multiplyer if boosting else 1.0
		ship.apply_central_force(direction * ship.data.speed * boost)
		ship.linear_velocity.x = clampf(ship.linear_velocity.x, -(ship.data.speed/2) * boost, (ship.data.speed/2) * boost)
		ship.linear_velocity.y = clampf(ship.linear_velocity.y, -(ship.data.speed/2) * boost, (ship.data.speed/2) * boost)


func _toggle_boost(action_id:StringName, toggle:bool) -> void:
	if action_id == data.id:
		boosting = toggle