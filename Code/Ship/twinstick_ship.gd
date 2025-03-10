class_name TwinStickShip extends Ship


var aim_direction:Vector2 = Vector2.ZERO
var aim_rot:float = 0.0

func _physics_process(delta: float) -> void:
	if aim_direction != Vector2.ZERO: 
		aim_direction = to_global(aim_direction)
		look_at(aim_direction)
	else:
		rotation = aim_rot
