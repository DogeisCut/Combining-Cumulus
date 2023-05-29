extends Control

func _on_button_pressed():
	Fade.transition_to("res://src/levels/level_1.tscn","FadeInOut")
