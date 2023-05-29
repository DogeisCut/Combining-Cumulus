@tool
extends Node2D
class_name Bridge

@export var enabled := false : set = set_enabled

func set_enabled(to):
	enabled = to
	update_enabledness()

func button_activate():
	set_enabled(true)

func button_deactivate():
	set_enabled(false)

func update_enabledness():
	if enabled:
		$Area2D/CollisionShape2D.disabled = false
		$Polygon2D.show()
		$Polygon2D2.hide()
	else:
		$Area2D/CollisionShape2D.disabled = true
		$Polygon2D2.show()
		$Polygon2D.hide()
