class_name MainMenu extends Control


@export var play_target:StringName = ""
@export var play_show_loading:bool = true

@onready var btn_play: Button = %btn_play
@onready var btn_settings: Button = %btn_settings
@onready var btn_credits: Button = %btn_credits


func _ready() -> void:
	btn_play.pressed.connect(_btn_play_pressed)
	btn_settings.pressed.connect(_btn_settings_pressed)
	btn_credits.pressed.connect(_btn_credits_pressed)


func _btn_play_pressed() -> void:
	Signals.LoadScene.emit(play_target, play_show_loading)


func _btn_settings_pressed() -> void:
	pass


func _btn_credits_pressed() -> void:
	pass
