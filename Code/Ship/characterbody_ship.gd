class_name CharacterBodyShip extends CharacterBody2D


@export_group("Debug")
@export var debug_data:ShipData
@export var debug_spawn:bool = false


var data:ShipData = null
var direction:Vector2 = Vector2.ZERO
var last_direction:Vector2 = Vector2.ZERO


func _ready() -> void:
	if debug_spawn:
		if data == null: setup_ship()
		Signals.ShipReady.emit(self)


func setup_ship(new_data:ShipData = null) -> void:
	if new_data == null:
		data = debug_data.duplicate()
	else:
		data = new_data
