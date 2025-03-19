class_name MovingBomb extends Projectile


@onready var attack_collider: CollisionShape2D = %attack_collider
@onready var explosion: Sprite2D = %explosion



func destroy_self() -> void:
	attack_collider.disabled = false
	explosion.show()
	await get_tree().create_timer(0.4).timeout
	queue_free()
