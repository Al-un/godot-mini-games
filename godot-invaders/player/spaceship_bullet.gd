extends Area2D

const SPEED = 300

func _process(delta: float) -> void:
	var target_velocity = Vector2.UP * SPEED
	position += target_velocity * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
