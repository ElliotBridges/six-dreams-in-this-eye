extends Spatial

const MAX_SPEED = 1

var timer = 120
var scene = ""
var old_scene = scene
var has_moved = false

onready var body = $RigidBody
onready var r1 = $RigidBody/r1
onready var r2 = $RigidBody/r2
onready var r3 = $RigidBody/r3
onready var r4 = $RigidBody/r4
onready var r5 = $RigidBody/r5
onready var r6 = $RigidBody/r6

func _process(delta):
	scene = ''
	
	if floor(abs(body.linear_velocity.x)/MAX_SPEED)+floor(abs(body.linear_velocity.y)/MAX_SPEED)+floor(abs(body.linear_velocity.z)/MAX_SPEED) == 0:
		if has_moved:
			var value = 0
			if r1.get_collider():
				scene = "res://Scenes/Rooms/RoomFinal1.tscn"
			if r2.get_collider():
				scene = "res://Scenes/Rooms/RoomFinal2.tscn"
			if r3.get_collider():
				scene = "res://Scenes/Rooms/RoomFinal3.tscn"
			if r4.get_collider():
				scene = "res://Scenes/Rooms/RoomFinal4.tscn"
			if r5.get_collider():
				scene = "res://Scenes/Rooms/RoomFinal5.tscn"
			if r6.get_collider():
				scene = "res://Scenes/Rooms/RoomFinal6.tscn"
	else:
		has_moved = true
		
	if Input.is_action_pressed("num1"):
		scene = "res://Scenes/Rooms/RoomFinal1.tscn"
	if Input.is_action_pressed("num2"):
		scene = "res://Scenes/Rooms/RoomFinal2.tscn"
	if Input.is_action_pressed("num3"):
		scene = "res://Scenes/Rooms/RoomFinal3.tscn"
	if Input.is_action_pressed("num4"):
		scene = "res://Scenes/Rooms/RoomFinal4.tscn"
	if Input.is_action_pressed("num5"):
		scene = "res://Scenes/Rooms/RoomFinal5.tscn"
	if Input.is_action_pressed("num6"):
		scene = "res://Scenes/Rooms/RoomFinal6.tscn"
		
	if old_scene == scene and scene != '':
		timer -= 1
		if timer <= 0:
			Mind.change_scene(scene)
			Player.let_go_of_held_object()
	else:
		timer = 120
	
	old_scene = scene
		
	$Label.text = String(timer)
