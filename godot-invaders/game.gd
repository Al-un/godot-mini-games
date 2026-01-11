extends Node2D

@export var building_scene: PackedScene
@export var crab_scene: PackedScene
@export var octopus_scene: PackedScene

signal score_update(point: int)
signal next_level(level: int)
signal game_completed
signal game_over

# ==============================================================================

var building_min_x := 50.0
var building_max_x := 550.0
var building_y := 600.0
var ennemies_min_position := Vector2(50, 100)
var ennemies_max_position := Vector2(550, 300)

var current_level = 1
var ennemies_levels: Array[Array]

var current_ennemies_killed = 0
var created_ennemies_count = 0
 
# ==============================================================================

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ennemies_levels = [
		# Level 1
		[
			[2, crab_scene],
			[2, crab_scene]
		],
		# Level 2
		[
			[5, crab_scene],
			[5, crab_scene],
			[5, octopus_scene],
			[5, octopus_scene],
		],
		# Level 3
		[
			[7, crab_scene],
			[7, crab_scene],
			[7, octopus_scene],
			[7, octopus_scene],
		]
	]

	# For debugging only
	#new_game()

func _generate_ennemies_row(offset_y: int, ennemies_count: int, ennemy_type: PackedScene) -> void: 
	var ennemy_step_x = (ennemies_max_position.x - ennemies_min_position.x) / ennemies_count
	for i in range(ennemies_count):
		var ennemy := ennemy_type.instantiate()
		var offset := Vector2((i + 0.5)*ennemy_step_x, offset_y)
		ennemy.position = ennemies_min_position + offset
		ennemy.move_range_x = ennemy_step_x/2
		# https://forum.godotengine.org/t/how-to-connect-signals-to-an-instantiated-node/42538
		ennemy.dead.connect(_on_ennemy_killed)
		
		add_child(ennemy)

func _generate_ennemies_level(level: int) -> void:
	current_ennemies_killed = 0
	created_ennemies_count = 0
	
	var step_y = 50
	var level_configuration = ennemies_levels[level-1]
	for ennemy_row in range(level_configuration.size()):
		var ennemy_row_config = level_configuration[ennemy_row]
		var ennemies_count = ennemy_row_config[0]
		var ennemies_scene = ennemy_row_config[1]
		_generate_ennemies_row(ennemy_row*step_y, ennemies_count, ennemies_scene)
		
		created_ennemies_count += ennemies_count
	
	

func new_game(building_count := 4):
	# --- Generate ennemies
	current_level = 1
	_generate_ennemies_level(current_level)
	next_level.emit(current_level)
	
	# --- Generate buildings 
	# Float vs Integer: division not support. See
	# https://github.com/godotengine/godot-proposals/issues/11998
	var building_step_x = (building_max_x - building_min_x) / building_count
	for i in range(building_count):
		var building := building_scene.instantiate()
		building.position = Vector2(building_min_x + (i+0.5)*building_step_x, building_y)
		add_child(building)
		
func _on_ennemy_killed(point_on_kill: int) -> void:
	score_update.emit(point_on_kill)
	
	current_ennemies_killed += 1
	var ennemies_left = created_ennemies_count - current_ennemies_killed
	print("Ennemy killed! Points: ", point_on_kill, " Ennemies killed: ", current_ennemies_killed, " Ennemies left: ", ennemies_left)
	
	if ennemies_left == 0:
		current_level += 1
		print("Level completed! Moving to level: ", current_level)
		
		if current_level >= ennemies_levels.size():
			game_completed.emit()
		else:
			next_level.emit(current_level)
			_generate_ennemies_level(current_level)


func _on_spaceship_dead() -> void:
	print("Game Over!")
	game_over.emit()
