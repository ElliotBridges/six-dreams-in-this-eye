extends KinematicBody

onready var head = $Head
onready var ground_check = $GroundCheck

var speed = 5
var h_accel = 6
var air_accel = 1
var normal_accel = 10
var mouse_sensitivity = 0.2
var grav = 20
var jump = 7

var direction = Vector3()
var movement = Vector3()
var h_vel = Vector3()
var grav_vec = Vector3()
var full_contact = false

func _ready():
	print("hello player :)")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-89), deg2rad(89))
	
func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.is_mouse_button_pressed(1):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	
	direction = Vector3()
	
	if ground_check.is_colliding():
		full_contact = true
	else:
		full_contact = false
		
#	grav_vec += Vector3.DOWN * grav * delta
#	
#	if is_on_floor():
#		grav_vec.y = lerp(grav_vec.y,0,.9)
	
	if not is_on_floor():
		grav_vec += Vector3.DOWN * grav * delta
		h_accel = air_accel
	elif is_on_floor() and full_contact:
		grav_vec = -get_floor_normal() * grav
		h_accel = normal_accel
	else:
		grav_vec = -get_floor_normal()
		h_accel = normal_accel
	
	if Input.is_action_just_pressed("jump") and (is_on_floor() or ground_check.is_colliding()):
		grav_vec = Vector3.UP * jump
	
	if Input.is_action_pressed("move_forward"):
		direction -= transform.basis.z
	if Input.is_action_pressed("move_backward"):
		direction += transform.basis.z
	if Input.is_action_pressed("move_left"):
		direction -= transform.basis.x
	if Input.is_action_pressed("move_right"):
		direction += transform.basis.x
	
	direction = direction.normalized()

	h_vel = h_vel.linear_interpolate(direction * speed, h_accel * delta)
	movement.z = h_vel.z + grav_vec.z
	movement.x = h_vel.x + grav_vec.x
	movement.y = grav_vec.y
	
	move_and_slide(movement, Vector3.UP)
