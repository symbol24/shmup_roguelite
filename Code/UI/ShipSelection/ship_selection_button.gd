class_name ShipSelectionButton extends Control


@onready var btn_ship: TextureButton = %btn_ship

var ship_data:ShipData


func _ready() -> void:
	btn_ship.pressed.connect(_btn_ship_pressed)


func setup_button(data:ShipData, _unlocked_list:Array[StringName]) -> void:
	ship_data = data
	if ship_data == null:
		print("Error on ", name, " ship button, no data was received.")
		return
	
	if ship_data.small_icon_uid != "":
		var texture:CompressedTexture2D = load(ship_data.small_icon_uid)
		btn_ship.texture_normal = texture
	btn_ship.disabled = true
	if ship_data.unlocked_by_default:
		btn_ship.disabled = false
	if ship_data.id in _unlocked_list:
		btn_ship.disabled = false


func _btn_ship_pressed() -> void:
	Signals.ShipSelectionBtnPressed.emit(ship_data)
