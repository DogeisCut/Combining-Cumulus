extends CanvasLayer

var preset_scene: String
var fading:=false

func transition_to(scene,animation):
	preset_scene = scene
	fading=true
	$"%FadePlayer".play(animation)

func change_scene_to_file() -> void:
	var _a = get_tree().change_scene_to_packed(load(preset_scene))
	fading=false
