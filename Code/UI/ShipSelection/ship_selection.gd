class_name ShipSelectionMenu extends Control


const SHIPBUTTON:PackedScene = preload("uid://cyhs3gxheenpt")


@export var ship_list:ShipList
@export var start_destination:StringName = ""
@export var display_loading_on_start:bool = true

@onready var ship_buttons_hbox: HBoxContainer = %ship_buttons_hbox
@onready var large_ship_image: TextureRect = %large_ship_image
@onready var ship_name_label: Label = %ship_name_label
@onready var ship_detail_rtl: RichTextLabel = %ship_detail_rtl
@onready var btn_start: Button = %btn_start

var manager:MangerManager:
	get:
		if manager == null: manager = get_tree().get_first_node_in_group("Manager")
		if manager == null: print("Manager is null.")
		return manager

var selected_ship:ShipData
var ship_select_buttons:Array[ShipSelectionButton] = []


func _ready() -> void:
	Signals.ShipSelectionBtnPressed.connect(_select_ship)
	btn_start.pressed.connect(_btn_start_pressed)
	_build_ship_selection_buttons()
	_select_first_available_button()


func _select_ship(ship_data:ShipData) -> void:
	selected_ship = ship_data
	if selected_ship != null:
		if selected_ship.large_icon_uid != "":
			large_ship_image.texture = load(selected_ship.large_icon_uid) as CompressedTexture2D
		ship_name_label.text = tr(selected_ship.loc_display_name) if selected_ship.loc_display_name != "" else selected_ship.debug_display_name
		ship_detail_rtl.text = tr(selected_ship.loc_description) if selected_ship.loc_description != "" else selected_ship.debug_description


func _build_ship_selection_buttons() -> void:
	if manager != null and ship_list != null:
		for ship:ShipData in ship_list.ships:
			var button:ShipSelectionButton = SHIPBUTTON.instantiate()
			ship_buttons_hbox.add_child(button)
			if not button.is_node_ready(): await button.ready
			button.name = "btn_ship_" + ship.id
			button.setup_button(ship, manager.save_load.current_save.unlocked_ships)
			ship_select_buttons.append(button)


func _btn_start_pressed() -> void:
	if manager != null:
		manager.save_load.current_save.set_current_ship(selected_ship.id)
		Signals.LoadScene.emit(start_destination, display_loading_on_start)


func _select_first_available_button() -> void:
	for button in ship_select_buttons:
		if not button.btn_ship.disabled:
			_select_ship(button.ship_data)
			button.btn_ship.grab_focus()
