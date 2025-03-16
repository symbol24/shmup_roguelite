class_name MangerManager extends Node


const SAVELOAD:String = "uid://c1pegw6x2172m"
const SCENEMANAGER:String = "uid://bofyhb5fhgtkq"


var save_load:SaveLoadManager = null
var scene_manager:SceneManager = null

var to_load:String
var load_sn:StringName
var progress:Array = []
var status:ResourceLoader.ThreadLoadStatus
var loading:bool = false


func _ready() -> void:
	Signals.LoadManager.connect(_load_manager)


func _process(_delta: float) -> void:
	if loading:
		status = ResourceLoader.load_threaded_get_status(to_load, progress)
		if status == ResourceLoader.THREAD_LOAD_LOADED:
			_complete_load()


func _load_manager(id:StringName = "") -> void:
	if not loading:
		to_load = ""
		load_sn = id
		match id:
			&"save_load":
				to_load = SAVELOAD
			&"scene_manager":
				to_load = SCENEMANAGER
			_:
				pass
		if to_load != "":
			ResourceLoader.load_threaded_request(to_load)
			loading = true
	else:
		print("Manager loading in progress already.")


func _complete_load() -> void:
	loading = false
	var temp = ResourceLoader.load_threaded_get(to_load)
	
	match load_sn:
		&"save_load":
			save_load = temp.instantiate()
			add_child.call_deferred(save_load)
			if not save_load.is_node_ready(): await save_load.ready
		&"scene_manager":
			scene_manager = temp.instantiate()
			add_child.call_deferred(scene_manager)
			if not scene_manager.is_node_ready(): await scene_manager.ready
		_:
			pass
	
	Signals.ManagerLoaded.emit(load_sn)
