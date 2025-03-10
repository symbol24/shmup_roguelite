class_name Laser extends Projectile


@onready var laser_line: Line2D = %laser_line
@onready var laser_collider: CollisionShape2D = %laser_collider


func setup_length(length:float = 100.0) -> void:
	laser_line.points[1].y = -length
	laser_collider.shape.size.y = length
	laser_collider.position.y = -length/2


func _on_body_entered(_body:Node2D) -> void:
	pass


func destroy_self() -> void:
	pass
