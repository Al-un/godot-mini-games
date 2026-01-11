extends BaseEnnemy


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	max_health = 1
	current_health = 1
	point_on_kill = 10
