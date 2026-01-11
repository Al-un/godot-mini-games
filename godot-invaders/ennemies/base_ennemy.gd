class_name BaseEnnemy
extends RigidBody2D

signal hit
signal dead(point: int)

const SPEED = 30

# https://github.com/Cofica17/2d_enemy_fire_bullet_at_player/blob/main/enemy/Enemy.gd\
@onready var player = get_tree().get_first_node_in_group("player")
var ennemy_bullet_scene = load("res://ennemies/ennemy_bullet.tscn")

@export var max_health: int
@export var shoot_cooldown := 1
var current_health: int
var initial_position: Vector2
var move_range_x: int
var direction: int # 1 = right, -1 - left
var point_on_kill: int

## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var viewport_size = get_viewport_rect().size
	initial_position = position
	if move_range_x == null:
		move_range_x = 50
	direction = 1
	current_health = 1
	max_health = 1
	point_on_kill = 10
	
	$ShootingTimer.start(shoot_cooldown)
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var movement = Vector2(direction*delta*SPEED, 0)
	position += movement
	
	if (position.x >= initial_position.x + move_range_x || position.x <= initial_position.x - move_range_x):
		#print("move_range_x: ", move_range_x)
		position.y += 20
		direction *= -1

func on_hit() -> void:
	current_health -= 1
	hit.emit()
	
	if current_health == 0:
		dead.emit(point_on_kill)
		queue_free()

func shoot() -> void:
	var bullet = ennemy_bullet_scene.instantiate()
	add_child(bullet)
	bullet.direction = global_position.direction_to(player.global_position)
	bullet.global_position = global_position

func _on_shooting_timer_timeout() -> void:
	if randf() > 0.1:
		shoot()
