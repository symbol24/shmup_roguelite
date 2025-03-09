class_name HitBox extends Area2D


var parent:RigidBody2D
var can_receive:bool = true


func _ready() -> void:
	parent = get_parent()


func area_entered(area:Area2D) -> void:
	if can_receive and area.has_method("get_damage"):
		if parent.has_method("receive_damage"): 
			parent.receive_damage(area.get_damage())
			_toggle_receive()


func _toggle_receive() -> void:
	if can_receive:
		can_receive = false
		get_tree().create_timer(0.1).timeout.connect(_toggle_receive)
	else:
		can_receive = true