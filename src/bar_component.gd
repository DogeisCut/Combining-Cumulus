@tool
extends Node2D
class_name BarComponent

signal updated(old_amount: int, new_amount: int)

@export var amount: int = 0 : set = set_amount
@export var max_amount: int = 3

@export var active_color := Color8(16, 162, 216)
@export var inactive_color := Color8(16, 16, 16)

func _ready():
	set_amount(amount)

func set_amount(to: int):
	updated.emit(amount, to)
	amount = clamp(to,0,max_amount)
	$"1".modulate = active_color # Always the case
	var nodes = [$"2", $"3", $"4"] # Name independent!
	for i in range(max_amount):
		nodes[i].modulate = active_color if amount > i else inactive_color
