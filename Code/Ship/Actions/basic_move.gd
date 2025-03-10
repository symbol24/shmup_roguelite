class_name BasicMove extends ShipAction


var direction:Vector2 = Vector2.ZERO


func _physics_process(_delta: float) -> void:
	if can_act:
		direction = Input.get_vector("left", "right", "up", "down")
		ship.apply_central_force(direction * ship.data.speed)
		ship.linear_velocity.x = clampf(ship.linear_velocity.x, -ship.data.speed/2, ship.data.speed/2)
		ship.linear_velocity.y = clampf(ship.linear_velocity.y, -ship.data.speed/2, ship.data.speed/2)
