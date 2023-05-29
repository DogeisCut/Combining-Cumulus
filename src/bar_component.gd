@tool
extends Node2D
class_name BarComponent

signal updated(old_amount: int, new_amount: int)

@export var amount: int = 0 : set = set_amount
@export var max_amount: int = 3

@export var active_color:=Color(0.0627451017499, 0.63529413938522, 0.84705883264542)

func _ready():
	set_amount(amount)

func set_amount(to: int):
	updated.emit(amount, to)
	amount = clamp(to,0,max_amount)
	match(amount):
		0:
			$"1".modulate = active_color
			$"2".modulate = Color(0.0627451017499, 0.0627451017499, 0.0627451017499)
			$"3".modulate = Color(0.0627451017499, 0.0627451017499, 0.0627451017499)
			$"4".modulate = Color(0.0627451017499, 0.0627451017499, 0.0627451017499)
		1:
			$"1".modulate = active_color
			$"2".modulate = active_color
			$"3".modulate = Color(0.0627451017499, 0.0627451017499, 0.0627451017499)
			$"4".modulate = Color(0.0627451017499, 0.0627451017499, 0.0627451017499)
		2:
			$"1".modulate = active_color
			$"2".modulate = active_color
			$"3".modulate = active_color
			$"4".modulate = Color(0.0627451017499, 0.0627451017499, 0.0627451017499)
		3:
			$"1".modulate = active_color
			$"2".modulate = active_color
			$"3".modulate = active_color
			$"4".modulate = active_color
