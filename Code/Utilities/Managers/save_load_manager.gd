class_name SaveLoadManager extends Node


const SAVEFOLDER:String = "user://saves/"
const SAVEFILEEXT:String = "save"


var current_save:PlayerData = null
var all_saves:Array[PlayerData] = []


func _ready() -> void:
	if _check_folder():
		all_saves = _load_save_files()


func _load_save_files() -> Array[PlayerData]:
	var saves:Array[PlayerData] = []
	var dir:DirAccess = DirAccess.open(SAVEFOLDER)
	var files:PackedStringArray = dir.get_files()
	for file in files:
		if file.get_extension() == SAVEFILEEXT:
			var temp:PlayerData = load(SAVEFOLDER+file) as PlayerData
			saves.append(temp)
	return saves


func _load_for_id(_id:StringName = "") -> void:
	for each in all_saves:
		if each.id == _id:
			current_save = each
			return
	print("No save file found for id ", _id)


func _save_all() -> void:
	for each in all_saves:
		ResourceSaver.save(each)


func _check_folder() -> bool:
	var dir:DirAccess = DirAccess.open(SAVEFOLDER)
	if dir == null:
		var result = DirAccess.make_dir_absolute(SAVEFOLDER)
		if result != OK:
			print_debug("Error creating save folder: ", result)
			return false
	return true
