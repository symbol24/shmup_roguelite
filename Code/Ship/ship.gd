class_name Ship extends RigidBody2D


@export_group("Debug")
@export var debug_data:ShipData
@export var debug_spawn:bool = false


var data:ShipData = null
var last_direction:Vector2 = Vector2.ZERO
var actions:Array[ShipAction] = []
var look_at_point:Vector2 = Vector2.ZERO
var look_rotation:float = 0.0
var look:bool = false

func _ready() -> void:
	if debug_spawn:
		if data == null: setup_ship()
		Signals.ShipReady.emit(self)


<<<<<<< HEAD
func _physics_process(delta: float) -> void:
	var direction:Vector2 = Input.get_vector("left", "right", "up", "down")
	var target_angle:float = Vector2.UP.angle_to(last_direction)
	if direction != Vector2.ZERO: 
		target_angle = Vector2.UP.angle_to(direction)
		last_direction = direction
	if linear_velocity.length_squared() > 0:
		rotation = lerp_angle(rotation, target_angle, delta * 10)
=======
func _physics_process(_delta: float) -> void:
	if not look and look_at_point != Vector2.ZERO: look_at(look_at_point)
	elif look: rotation = look_rotation
	
>>>>>>> symbol/twinstick_commit


func setup_ship(new_data:ShipData = null) -> void:
	if new_data == null:
		data = debug_data.duplicate()

	else:
		data = new_data
	
	linear_damp = data.dampening
