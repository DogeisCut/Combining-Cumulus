@tool
extends Node2D
class_name Redirector

@export_enum("Up","Right","Down","Left") var direction: int : set = set_direction

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

func set_direction(to):
	match(to):
		0:
			$Graphics.rotation_degrees = 0
		1:
			$Graphics.rotation_degrees = 90
		2:
			$Graphics.rotation_degrees = 180
		3:
			$Graphics.rotation_degrees = 270
	direction=to

func _ready():
	set_direction(direction)
	tile_pos = Vector2i(position/64)
