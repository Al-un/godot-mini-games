class_name Building
extends Area2D

signal destroyed

# ==============================================================================

var max_health: int
var current_health: int

# Preload as we will always need buildings. Example taken from Copilot :(
const SPRITESHEET = preload("res://assets/SpaceInvaders.png")
const SPRITE_REGIONS := {
	"full_life": Rect2(51, 20, 26, 12),
	"lightly_hurt": Rect2(51, 36, 26, 12),
	"badly_hurt": Rect2(51, 52, 26, 12),
	"almost_dead": Rect2(51, 68, 26, 12)
}
var _atlas_cache: Dictionary = {}

# ==============================================================================

## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_health = 10
	max_health = 10
	
	# Pre-cache recommended by Copilot
	for region_name in SPRITE_REGIONS.keys():
		var atlas := AtlasTexture.new()
		atlas.atlas = SPRITESHEET
		atlas.region = SPRITE_REGIONS[region_name]
		_atlas_cache[region_name] = atlas

func _update_visuals() -> void:
	var sprite_name = "full_life"
	
	if current_health < 0.25*max_health:
		sprite_name = "almost_dead"
	elif current_health < 0.5*max_health:
		sprite_name = "badly_hurt"
	elif current_health < max_health:
		sprite_name = "lightly_hurt"
	
	$Sprite2D.texture = _atlas_cache.get(sprite_name)

func on_hit() -> void:
	current_health -= 1
	_update_visuals()
	
	if current_health == 0:
		destroyed.emit()
		queue_free()

# The bullet is an area, not a body identiable by "CharacterBody2D". From the 
# Godot documentation: https://docs.godotengine.org/en/stable/tutorials/physics/using_area_2d.html
# -----
# To detect the overlap, we'll connect the appropriate signal on the Area2D. 
# Which signal to use depends on the player's node type. If the player is another
# area, use area_entered. However, let's assume our player is a CharacterBody2D 
# (and therefore a CollisionObject2D type), so we'll connect the body_entered signal.
# -----
func _on_area_entered(area: Area2D) -> void:
	#print("Building hit by: ", area.name)
	# Whatever hits it (spaceship bullet or ennemy bullet) just hits it
	on_hit()
	# kill the incoming object
	area.queue_free()
