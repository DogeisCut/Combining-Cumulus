extends Node2D
class_name Cloud

const TILESIZE = 64
@export var size := 0 : set = set_size

@onready var barComp := $Graphics/BarComponent

var overlapping_clouds : Array[Cloud]
var overlapping_plants : Array[Plant]
var overlapping_redirectors : Array[Redirector]
var overlapping_buttons : Array[WaterButton]
var leaving_plants : Array[Plant]

@onready var trail_scene := preload("res://src/trail.tscn")

var tile_pos: Vector2i

signal updated(old_size: int, new_size: int)

func _ready():
	tile_pos = Vector2i(position/TILESIZE)
	call_deferred("check_for_clouds")
	call_deferred("check_for_flowers")

func set_size(to: int):
	updated.emit(size, to)
	size = clamp(to,0,$Graphics/BarComponent.max_amount)
	$Graphics/BarComponent.set_amount(size)

var fusing:=false
var killme:=false

func move():
	if Input.is_action_just_pressed("down"):
		move_and_check(Vector2i(0,1))
		return
	if Input.is_action_just_pressed("up"):
		move_and_check(Vector2i(0,-1))
		return
	if Input.is_action_just_pressed("right"):
		move_and_check(Vector2i(1,0))
		return
	if Input.is_action_just_pressed("left"):
		move_and_check(Vector2i(-1,0))
		return

var tween
func move_and_check(dir: Vector2i):
	$RayCast2D.target_position = Vector2(dir*TILESIZE)
	var old_pos = global_position
	var move_max: int = 0
	while update_and_check() and move_max<999999999999:
		var trail = trail_scene.instantiate()
		trail.global_position = global_position
		trail.rotation = Vector2(dir).angle()
		get_parent().add_child(trail)
		$RayCast2D.target_position = Vector2(dir*TILESIZE)
		position += Vector2(dir*TILESIZE)
		tile_pos = Vector2i(position/TILESIZE)
		update_overlapping_redirectors()
		for redirector in overlapping_redirectors:
			if !redirector.enabled:
				continue
			redirector.redirect()
			match(redirector.direction):
				0:
					dir = Vector2i(0,-1)
				1:
					dir = Vector2i(1,0)
				2:
					dir = Vector2i(0,1)
				3:
					dir = Vector2i(-1,0)
			$RayCast2D.target_position = Vector2(dir*TILESIZE)
			$RayCast2D.force_raycast_update()
		move_max += 1
	$Graphics.global_position = old_pos
func after_move():
	if tween:
		tween.kill()
	tween = create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property($Graphics, "global_position", global_position, 0.1)
	tween.tween_callback(queue_freeable)
	check_for_clouds()
	check_for_flowers()
	update_overlapping_buttons()
	for button in overlapping_buttons:
		if button.water_level_needed==-1:
			button.activate()
		elif button.water_level_needed==size:
			button.activate()

func queue_freeable():
	if fusing or killme:
		queue_free()

func check_for_clouds():
	update_overlapping_clouds()
	for cloud in overlapping_clouds:
		if !cloud.fusing and !fusing and cloud.tile_pos == tile_pos:
			fusing = true
			cloud.set_size(cloud.size+size+1)
			cloud.get_node("Graphics/PoofSound").play()
			cloud.get_node("Poof").restart()
			cloud.get_node("Poof").emitting = true
			cloud.get_node("Graphics/AnimationPlayer").stop()
			cloud.get_node("Graphics/AnimationPlayer").play("poof")
			cloud.check_for_flowers()

func update_and_check():
	$RayCast2D.force_raycast_update()
	return $RayCast2D.is_colliding()

func check_for_flowers():
	update_overlapping_plants()
	if !fusing:
		for plant in overlapping_plants:
			if size == plant.wanted_rain_amount:
				if !plant.satisfed:
					plant.set_satisfied(true)
			else:
				plant.set_satisfied(false)
	for plant in leaving_plants:
		if plant.satisfed:
			plant.set_satisfied(false)
	

func update_overlapping_clouds():
	overlapping_clouds = []
	var clouds = get_tree().get_nodes_in_group("Cloud")
	clouds.erase(self)
	for cloud in clouds:
		if cloud.tile_pos == tile_pos:
			overlapping_clouds.append(cloud)
func update_overlapping_plants():
	leaving_plants = overlapping_plants.duplicate()
	overlapping_plants = []
	var plants = get_tree().get_nodes_in_group("Plant")
	for plant in plants:
		if plant.tile_pos == tile_pos:
			overlapping_plants.append(plant)
			leaving_plants.erase(plant)
func update_overlapping_redirectors():
	overlapping_redirectors = []
	var redirectors = get_tree().get_nodes_in_group("Redirector")
	redirectors.erase(self)
	for redirector in redirectors:
		if redirector.tile_pos == tile_pos:
			overlapping_redirectors.append(redirector)
func update_overlapping_buttons():
	overlapping_buttons = []
	var buttons = get_tree().get_nodes_in_group("Button")
	buttons.erase(self)
	for button in buttons:
		if button.tile_pos == tile_pos:
			overlapping_buttons.append(button)
