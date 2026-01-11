# Godot Invaders

A copy of Space Invaders ([Wikipedia](https://en.wikipedia.org/wiki/Space_Invaders)), the
original shoot'em up from 1978, created in Godot 4.5.

## Key Features

This game, as a practice, is not a proper copy of the original space invader but an
overly simplified one:

- Player can move left and right and shoot rockets at aliens
- Buildings protect, up to a certain level of damages, the city and the Player
- Ennemies, aliens, spawn, move left and right before approaching the city and
  bombard the city and the Player with their own missiles.

  There are two levels only which displays two patterns of ennemies

## Key Learnings

TL;DR learnings:

- **player, ennemies and bullets**:
  - 
- **visual management**:
  - 
- **Abstractions**:
  - 

### Player, Ennemies and Bullets

### Visual Management

### Abstractions

## Assets

This game could be achieved thanks to the following assets:

- Visual Assets: https://comp3interactive.itch.io/invaders-from-outerspace-full-project-asset-pack
- Font: https://www.fontspace.com/cosmic-alien-font-f3323

## References

### Space Invader like implementation

- https://forum.godotengine.org/t/space-invaders-for-everyone/104146: a single-block code to generate
  a space invader like game. I have not tested it personally.
- https://github.com/Hernandez712/SpaceInvaders-Godot: another Space Invader copy that I used as
  reference

### Godot Techniques

**Sprite Management**
- https://www.spritecook.ai/godot-sprites: How to use sprite frames in Godot

**2D Bodies**:
- https://uhiyama-lab.com/en/notes/godot/physics-body-comparison/: explanation of the
  differences between `RigidBody2D` and `CharacterBody2D`
- https://forum.godotengine.org/t/should-projectiles-be-area2d-or-rigidbody2d/44418:
  Forum discusssion regarding using `Area2D` or `RigidBullet2D` for bullets

**Ennemies and Bullets**
- https://kidscancode.org/godot_recipes/4.x/2d/2d_shooting/: a tutorial to spawn bullets
  that evolves independently from Player's position and direction
- https://medium.com/@filipbs/godot-make-enemy-fire-a-bullet-at-the-player-or-any-target-in-2d-645553868dcf:
  tutorial to make ennemies firing bullets

**GD Script coding**:
- https://www.gotut.net/inheritance-in-godot-4/: How to define scene abstraction thanks to scene
  inheritance
- https://www.gdquest.com/tutorial/godot/design-patterns/entity-component-pattern/: Entity-Component
  design pattern for code re-usability and flexibility. I ended up not using it as it looks like the 
  hitbox/hurtbox that is overkill for the current game.
- https://www.gdquest.com/library/hitbox_hurtbox_godot4/: weapon and target model
