class_name BaseEnnemy
extends RigidBody2D

signal hit
signal dead

@export var max_health: int
var current_health: int
var initial_position: Vector2
var min_x: int
var max_x: int
var direction: int # 1 = right, -1 - left

## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var viewport_size = get_viewport_rect().size
	initial_position = position
	min_x = position.x - 30
	max_x = position.x + 30
	direction = 1
	current_health = 1
	max_health = 1
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var movement = Vector2(direction*delta*50, 0)
	position += movement
	
	if (position.x >= max_x || position.x <= min_x):
		position.y += 20
		direction *= -1
	

func initialize(start_health: int) -> void:
	max_health = start_health

func on_hit() -> void:
	current_health -= 1
	hit.emit()
	
	if current_health == 0:
		dead.emit()
		queue_free()
