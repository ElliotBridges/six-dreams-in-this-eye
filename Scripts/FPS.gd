extends KinematicBody


var speed = 5
const ACCEL_DEFAULT = 7
const ACCEL_AIR = 1
onready var accel = ACCEL_DEFAULT
var gravity = 9.8
var jump = 5

var cam_accel = 40
var mouse_sense = 0.25
var snap

var paused = false

var direction = Vector3()
var velocity = Vector3()
var gravity_vec = Vector3()
var movement = Vector3()

var held_object: Object

onready var head = $Head
onready var camera = $Head/Camera
onready var InteractRaycast = $Head/RayCast
onready var hold_position = $Head/HoldPosition
onready var InteractIndecator = $Head/InteractIndecator
onready var InteractIndecator2 = $Head/InteractIndecator/MeshInstance

func _ready():
	#hides the cursor
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Mind.mouse_sense = mouse_sense
	if Mind.player_globals != null:
		global_transform.origin = Mind.player_globals

func _input(event):
	#get mouse input for camera rotation
	if not paused:
		if event is InputEventMouseMotion:
			rotate_y(deg2rad(-event.relative.x * mouse_sense))
			head.rotate_x(deg2rad(-event.relative.y * mouse_sense))
			head.rotation.x = clamp(head.rotation.x, deg2rad(-89), deg2rad(89))

func _process(delta):
	# always update that mouse sence
	mouse_sense = Mind.mouse_sense
	
	#change scene if we are down bellow
	if global_transform.origin.y <= -100:
		global_transform.origin = Vector3(0,10,0)
		Mind.change_scene("res://Scenes/Rooms/RoomFinal0.tscn")
	
	#camera physics interpolation to reduce physics jitter on high refresh-rate monitors
	if not paused:
		if Engine.get_frames_per_second() > Engine.iterations_per_second:
			camera.set_as_toplevel(true)
			camera.global_transform.origin = camera.global_transform.origin.linear_interpolate(head.global_transform.origin, cam_accel * delta)
			camera.rotation.y = rotation.y
			camera.rotation.x = head.rotation.x
		else:
			camera.set_as_toplevel(false)
			camera.global_transform = head.global_transform
			
		#crouch
		if Input.is_action_just_pressed("crouch"):
			crouch()
		
		#Interaction Code
		var raycol = InteractRaycast.get_collider()
		
		InteractIndecator.visible = true
		if raycol:
			InteractIndecator2.visible = true
			$Label.text = ':'+String(raycol.name)+':'
		else:
			InteractIndecator2.visible = false
			$Label.text = ':null:'
		
		if Input.is_action_just_pressed("interact"):
			if raycol and raycol.name == "NPC":
					raycol.get_parent().talk()
			else:
				if held_object:
					let_go_of_held_object()
				else:
					if raycol and not raycol.get_collision_layer_bit(4):
						if raycol.mode == RigidBody.MODE_RIGID:
							held_object = raycol
							held_object.mode = RigidBody.MODE_KINEMATIC
							held_object.collision_mask = 0
				
		if held_object:
			held_object.linear_velocity.x = 100
			held_object.global_transform.origin = hold_position.global_transform.origin
			held_object.rotation.x = head.rotation.x
			held_object.rotation.y = rotation.y
			held_object.rotation.z = rotation.z
			
		#Stuff for telling MIND where the player is
		#Mind.playerGlobalTransform = global_transform.origin
	else:
		InteractIndecator.visible = false

func let_go_of_held_object():
	if held_object:
		held_object.mode = RigidBody.MODE_RIGID
		held_object.collision_mask = 1
		if held_object.get_collision_layer_bit(3):
			#held_object.apply_impulse(Vector3(0,0,0),$Head/HoldPosition/RayCast.transform.basis.y*-3)
			held_object.apply_torque_impulse(Vector3(rand_range(-.2,.2),rand_range(-.2,.2),rand_range(-.2,.2)))
			#held_object.apply_force_impulse(Vector3(rand_range(-.2,.2),rand_range(-.2,.2),rand_range(-.2,.2)))
		held_object = null
	
func crouch():
	$StandCollision.visible = not $StandCollision.visible
	if $StandCollision.visible:
		$Head.translation.y += 1
	else:
		$Head.translation.y -= 1
		

func _physics_process(delta):
	#get keyboard input
	direction = Vector3.ZERO
	var h_rot = global_transform.basis.get_euler().y
	var f_input = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	var h_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if paused:
		f_input = 0
		h_input = 0
	direction = Vector3(h_input, 0, f_input).rotated(Vector3.UP, h_rot).normalized()
	
	#jumping and gravity
	if is_on_floor():
		snap = -get_floor_normal()
		accel = ACCEL_DEFAULT
		gravity_vec = Vector3.ZERO
	else:
		snap = Vector3.DOWN
		accel = ACCEL_AIR
		gravity_vec += Vector3.DOWN * gravity * delta
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		snap = Vector3.ZERO
		gravity_vec = Vector3.UP * jump
	
	#make it move
	velocity = velocity.linear_interpolate(direction * speed, accel * delta)
	movement = velocity + gravity_vec
	
# warning-ignore:return_value_discarded
	move_and_slide_with_snap(movement, snap, Vector3.UP, true, 4, deg2rad(89))
	
	
	
