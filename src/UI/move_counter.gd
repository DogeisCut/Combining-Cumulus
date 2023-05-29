extends CanvasLayer

var iknowit:int
var goodbye:=false

func _process(_delta):
	if is_instance_valid(MoveSystem.current_level):
		$Label.text = "WIND LEFT:" + str(MoveSystem.moves)
		if MoveSystem.current_level.won:
			if !goodbye:
				goodbye=true
				$AnimationPlayer.stop()
				$AnimationPlayer.play("win")
		elif iknowit!=MoveSystem.moves:
			iknowit = MoveSystem.moves
			$AnimationPlayer.stop()
			$AnimationPlayer.play("bump")

func _ready():
	$Label.pivot_offset = $Label.size/2
	show()

func _on_label_resized():
	$Label.pivot_offset = $Label.size/2


func _on_button_pressed():
	MoveSystem.restart_level()
