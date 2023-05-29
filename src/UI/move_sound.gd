extends AudioStreamPlayer

func _ready():
	MoveSystem.move.connect(move)

func move():
	play()
