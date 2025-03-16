class_name PlayerData extends Resource


@export var id:StringName = ""
@export var current_ship:StringName = ""

var changes_pending:bool = false
# Settings will go here


func set_current_ship(id:StringName) -> void:
	if current_ship != id:
		current_ship = id
		changes_pending = true
