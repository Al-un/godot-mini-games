extends Area2D

const SPEED = 500

func _process(delta: float) -> void:
	var target_velocity = Vector2.UP * SPEED
	position += target_velocity * delta

	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	#print("Spaceship bullet/Entered body: ", body.name)
	if body.is_in_group("ennemies"):
		body.on_hit()
		queue_free()

func _on_area_entered(_area: Area2D) -> void:
	#print("Spaceship bullet/Entered area: ", area.name)
	pass
