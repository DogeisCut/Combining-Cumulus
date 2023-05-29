extends Node2D
class_name Plant

@export var wanted_rain_amount := 0

var satisfed := false: set = set_satisfied

var tile_pos: Vector2i

func set_satisfied(to: bool):
	if satisfed != to:
		$Graphics/Glow.visible = to
		if to == true:
			$Graphics/AnimationPlayer.play("dance")
			$Graphics/pos.play()
			$Graphics/Poof.restart()
			$Graphics/Poof.emitting = true
			MoveSystem.current_level.add_flowers(1)
		else:
			$Graphics/AnimationPlayer.pause()
			$Graphics/neg.play()
			MoveSystem.current_level.add_flowers(-1)
		satisfed = to

# Called when the node enters the scene tree for the first time.
func _ready():
	tile_pos = Vector2i(position/64)
	$BarComponent.set_amount(wanted_rain_amount)
