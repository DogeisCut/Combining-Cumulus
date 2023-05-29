extends Node2D
class_name Level

var happy_plants := 0
var happy_plants_max : int

var won := false

@export_file("*.tscn") var next_level
@export var max_moves:int=0

func _ready():
	MoveSystem.move.connect(move, CONNECT_DEFERRED)
	MoveSystem.current_level = self 
	MoveSystem.moves = max_moves
	happy_plants_max = get_tree().get_nodes_in_group("Plant").size()

func add_flowers(amount: int):
	happy_plants+=amount

func move():
	#print("Happy Plants: " + str(happy_plants) + "/" + str(happy_plants_max))
	if happy_plants == happy_plants_max:
		won = true
		$WinScreen/AnimationPlayer.play("win")

func load_next_level():
	Fade.transition_to(next_level,"FadeInOut")
