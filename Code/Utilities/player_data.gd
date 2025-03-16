class_name PlayerData extends Resource


@export var id:StringName = ""
@export var current_ship:StringName = ""
@export var unlocked_ships:Array[StringName] = []

var changes_pending:bool = false
var current_difficulty:int = 0

# Settings will go here


func set_current_ship(_id:StringName) -> void:
	if current_ship != _id:
		current_ship = _id
		changes_pending = true


func update_unlocked_ships(new_unlock:StringName) -> void:
	if unlocked_ships.has(new_unlock):
		print("Ship already unloced.")
		return
		
	unlocked_ships.append(new_unlock)
	changes_pending = true
