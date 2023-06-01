extends Node2D
class_name Redirector

enum Direction {
	UP = 0,
	RIGHT = 90,
	DOWN = 180,
	LEFT = 270,
}

@export var direction: Direction : set = set_direction

@export var enabled := true : set = set_enabled

func set_enabled(to):
	enabled = to
	update_enabledness()

func update_enabledness():
	if enabled:
		$Graphics/Enabled.show()
		$Graphics/Disabled.hide()
	else:
		$Graphics/Disabled.show()
		$Graphics/Enabled.hide()

var tile_pos: Vector2i

## @returns: The direction that is being redirected in
func redirect() -> Vector2i:
	$Sound.play()
	$AnimationPlayer.stop()
	$AnimationPlayer.play("redirect")
	match(direction):
		Direction.UP:
			return Vector2i.UP
		Direction.RIGHT:
			return Vector2i.RIGHT
		Direction.DOWN:
			return Vector2i.DOWN
		Direction.LEFT:
			return Vector2i.LEFT
		_: # Will never happen because this is an exhaustive match
			return Vector2.ZERO # satisfies the return type checker

func set_direction(to: Direction):
	$Graphics.rotation_degrees = to
	direction=to

func _ready():
	set_direction(direction)
	tile_pos = Vector2i(position/64)
