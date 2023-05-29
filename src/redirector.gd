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

func redirect():
	$Sound.play()
	$AnimationPlayer.stop()
	$AnimationPlayer.play("redirect")

func set_direction(to: Direction):
	$Graphics.rotation_degrees = to
	direction=to

func _ready():
	set_direction(direction)
	tile_pos = Vector2i(position/64)
