extends Node2D

var score: int
var game_status := "Init"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset_main_text()

func _process(_delta) -> void:
	if Input.is_action_pressed("ui_accept") && game_status != "in_game":
		new_game()

func new_game() -> void:
	$Game.new_game()
	score = 0
	$ScoreLabel.text = "Score: %s" % score
	game_status = "in_game"
	$TextHUD.hide()

func _on_game_score_update(point: int) -> void:
	score += point
	$ScoreLabel.text = "Score: %s" % score

func _on_game_next_level(level: int) -> void:
	$LevelLabel.text = "Level: %s" % level

func reset_main_text():
	$TextHUD/MainTextLabel.text="Welcome to Godot Invaders!\n
	
	Move with left/right arrows and shoot with \"Space\".
	Press \"Enter\" to start"
	$TextHUD.show()

func _on_game_game_over() -> void:
	game_status = "game_over"
	$TextHUD/MainTextLabel.text="Game Over! 
	
	Press \"Enter\" to restart."
	$TextHUD.show()


func _on_game_game_completed() -> void:
	game_status = "game_completed"
	$TextHUD/MainTextLabel.text="Congratulations! You saved the city. 
	
	Press \"Enter\" to restart."
	$TextHUD.show()
