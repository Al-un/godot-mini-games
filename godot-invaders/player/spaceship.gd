extends CharacterBody2D

signal dead

@export var bullet_scene: PackedScene

const SPEED = 200.0
const JUMP_VELOCITY = -400.0
const WIDTH_BUFFER = 0.1

var clamp_min: Vector2
var clamp_max


func _ready() -> void:
	var viewport_size = get_viewport_rect().size
	clamp_min = Vector2(viewport_size.x * WIDTH_BUFFER, position.y)
	clamp_max = Vector2(viewport_size.x * (1-WIDTH_BUFFER), position.y)
	

func _process(delta: float) -> void:
	
	# Move spaceship
	var target_velocity = Vector2.ZERO
	if Input.is_action_pressed("move_left"):
		target_velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		target_velocity.x += 1
	
	if target_velocity.length() > 0:
		target_velocity = target_velocity.normalized() * SPEED

	position += target_velocity * delta
	position = position.clamp(clamp_min, clamp_max)
		
	# Shooot!
	if Input.is_action_just_pressed("shoot"):
		shoot()

func _physics_process(_delta: float) -> void:
	
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)

	# https://stackoverflow.com/a/69731270
	move_and_slide()
	for index in get_slide_collision_count():
		var collision := get_slide_collision(index)
		var body := collision.get_collider()
		print("Collided with: ", body.name)

func shoot() -> void:
	var bullet = bullet_scene.instantiate()
	bullet.position = position - Vector2(0, 35)
	owner.add_child(bullet)

func on_hit() -> void:
	dead.emit()
	


func _on_bullet_detector_area_entered(area: Area2D) -> void:
	print("Spaceship/BulletDetector: hit by ", area.name)
	on_hit()
