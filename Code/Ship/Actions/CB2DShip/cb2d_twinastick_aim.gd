class_name CB2DTwinStickAim extends ShipAction


@export var reticle_uid:String
@export var mouse_move_detection_time:float = 0.3

@onready var aim_point_for_controller: Marker2D = %aim_point_for_controller

var reticle:Sprite2D
var level:Node2D:
	get:
		if level == null: level = get_tree().get_first_node_in_group("level")
		return level
var ready_to_move:bool = false
var pos:Vector2 = Vector2.ZERO
var is_gamepad:bool = true
var last_direction:Vector2 = Vector2.ZERO
var last_rotation:float = 0.0

# TODO: Move mouse and gamepad detection into an input manager
var detecting_mouse_movement:bool = false
var mouse_move_detection_timer:float = 0.0:
	set(value):
		mouse_move_detection_timer = value
		if mouse_move_detection_timer >= mouse_move_detection_time:
			detecting_mouse_movement = false
			is_gamepad = false
			mouse_move_detection_timer = 0.0
			if ship: ship.rotation = last_rotation


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if is_gamepad:
			if event.velocity.length() > 0:
				detecting_mouse_movement = true
			else:
				detecting_mouse_movement = false
				mouse_move_detection_timer = 0.0
	elif event is InputEventJoypadButton or event is InputEventJoypadMotion:
		detecting_mouse_movement = false
		mouse_move_detection_timer = 0.0
		is_gamepad = true


func _ready() -> void:
	super()
	_spawn_reticle()
	aim_point_for_controller.position = Vector2(sqrt(data.life_time_distance), 0)
	
	
func _process(delta: float) -> void:
	if ready_to_move: 
		if is_gamepad:
			var direction:Vector2 = Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down")
			reticle.position = aim_point_for_controller.position
			var target_angle:float = Vector2.RIGHT.angle_to(last_direction)
			if direction != Vector2.ZERO: 
				if ship!= null: 
					ship.rotation = target_angle
				last_direction = direction
				if ship: last_rotation = ship.rotation
			else:
				if ship: ship.rotation = last_rotation
			
		else: 
			pos = get_local_mouse_position()
			reticle.position = pos
			if ship!= null: 
				var global_aim:Vector2 = to_global(pos)
				ship.look_at(global_aim)
				last_rotation = ship.rotation
	
	if detecting_mouse_movement: mouse_move_detection_timer += delta


func _spawn_reticle() -> void:
	if reticle == null:
		reticle = load(reticle_uid).instantiate()
		add_child.call_deferred(reticle)
		if not reticle.is_node_ready(): await reticle.ready
		ready_to_move = true
