extends Node2D

signal move
@export var current_level: Level

var moves:int

func do_move():
	moves -= 1
	move.emit()

func _input(_event: InputEvent):
	if is_instance_valid(current_level):
		if current_level.won == false:
			if moves>0: 
				var clouds = get_tree().get_nodes_in_group("Cloud")
				for cloud in clouds:
					cloud.move()
				for cloud in clouds:
					cloud.after_move()
				if Input.is_action_just_pressed("down"):
					do_move()
					return
				if Input.is_action_just_pressed("up"):
					do_move()
					return
				if Input.is_action_just_pressed("right"):
					do_move()
					return
				if Input.is_action_just_pressed("left"):
					do_move()
					return
			if Input.is_action_just_pressed("restart"):
				restart_level()

func restart_level():
	Fade.transition_to(get_tree().current_scene.scene_file_path,"FadeInOut")
