extends Area2D

const SPEED = 5

var direction = Vector2.ZERO

func _physics_process(_delta: float) -> void:
	position += direction * SPEED

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	print("Ennemy bullet/Entered body: ", body.name)
	if body.is_in_group("player"):
		body.on_hit()
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	print("Ennemy bullet/Entered area: ", area.name)
