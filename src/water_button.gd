extends Node2D
class_name WaterButton

@export var target: NodePath
@export var enable:=true

@export var line_y:=false

@export var water_level_needed:=-1

var activated := false

var tile_pos: Vector2i

func _ready():
	if water_level_needed>-1:
		$BarComponent.set_amount(water_level_needed)
	else:
		$BarComponent.hide()
	tile_pos = Vector2i(position/64)
	if get_node_or_null(target):
		if line_y:
			$LineClip/Line2D.points = [Vector2(0,0),Vector2(0,(get_node(target).global_position-global_position).y),get_node(target).global_position-global_position]
		else:
			$LineClip/Line2D.points = [Vector2(0,0),Vector2((get_node(target).global_position-global_position).x,0),get_node(target).global_position-global_position]
		$Circle3.global_position = get_node(target).global_position
		$LineClip.global_position = get_node(target).global_position
		$LineClip/Line2D.global_position = global_position

const active_color = Color8(151, 236, 208)

func activate():
	if !activated:
		activated = true
		$Activate.play()
		$Circle2.modulate = active_color
		$Circle3.modulate = active_color
		$LineClip/Line2D.default_color = active_color
		if get_node_or_null(target):
			if get_node(target).has_method("set_enabled"):
				get_node(target).set_enabled(enable)
			else:
				push_warning("Target node has no activate function, setting visibility...")
				get_node(target).visible = enable
		else:
			push_error("No target on button. What are you doing?")
