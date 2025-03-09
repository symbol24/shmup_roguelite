class_name ShipAction extends Node2D


@export var data:ActionData

var ship:Ship
var can_act:bool = false
var timer_active:bool = false
var delay_timer:float = 1.0
		


func _ready() -> void:
	Signals.ShipReady.connect(_activate)


func _process(delta: float) -> void:
	if timer_active: _reduce_delay_timer(delta)


func _activate(_ship:Ship) -> void:
	ship = _ship
	can_act = true


func _reduce_delay_timer(value:float = 0.0) -> void:
	delay_timer -= value
	delay_timer = max(0.0, delay_timer)
	Signals.ActionTimer.emit(data.id, delay_timer, data.action_delay)
	if delay_timer <= 0.0:
		can_act = true
		delay_timer = snappedf(data.action_delay / 1 + ship.data.attack_speed, 0.1)
		timer_active = false
