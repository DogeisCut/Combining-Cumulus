extends CanvasLayer


func _on_button_pressed():
	MoveSystem.current_level.load_next_level()

func _input(_event):
	if is_instance_valid(MoveSystem.current_level):
		if MoveSystem.current_level.get("won"):
			if Input.is_action_just_pressed("ui_accept"):
				MoveSystem.current_level.load_next_level()

func _ready():
	$Control/LevelComplete.pivot_offset = $Control/LevelComplete.size/2

func _on_level_complete_resized():
	$Control/LevelComplete.pivot_offset = $Control/LevelComplete.size/2
