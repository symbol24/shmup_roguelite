class_name CharacterBodyMove extends ShipAction


@onready var particles: CPUParticles2D = %particles
@onready var particles_2: CPUParticles2D = %particles2

var direction:Vector2 = Vector2.ZERO
var boosting:bool = false


func _ready() -> void:
	super()
	Signals.ActionToggled.connect(_toggle_boost)


func _physics_process(delta: float) -> void:
	if can_act:
		direction = Input.get_vector("left", "right", "up", "down")
		if ship != null:
			var vel:Vector2 = _get_velocity(direction, ship.velocity, delta)
			ship.velocity = vel
			ship.move_and_slide()


func _get_velocity(_direction:Vector2, current:Vector2, delta:float) -> Vector2:
	var new_vel:Vector2 = current
	var boost:float = data.boost_multiplyer if boosting else 1.0
	if _direction != Vector2.ZERO:
		new_vel = new_vel.move_toward(current + (_direction * ship.data.speed * boost), delta * ship.data.base_acceleration)
		new_vel.x = clampf(new_vel.x, -ship.data.speed, ship.data.speed)
		new_vel.y = clampf(new_vel.y, -ship.data.speed, ship.data.speed)
	else:
		new_vel = new_vel.move_toward(Vector2.ZERO, delta * ship.data.base_friction)
	return new_vel


func _toggle_boost(action_id:StringName, toggle:bool) -> void:
	if action_id == data.id:
		boosting = toggle
		if boosting: particles_2.emitting = true
		else: particles_2.emitting = false
