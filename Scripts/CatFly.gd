extends Spatial

var fly = false
var y_vel = 0
onready var Head = $Cat/Head
var timer = 200

const PI2 = PI*2

func _ready():
	if Mind.cat_found_in_room[Mind.in_room]:
		queue_free()

func _process(delta):
	
	if fly == true:
		timer -= 1
		if timer <= 0:
			y_vel += .00075
	global_transform.origin += Vector3(0, y_vel, 0)
	
	#check for fly away
	if Player.InteractRaycast.get_collider() and not fly:
		if Player.InteractRaycast.get_collider().name == 'CatBody':
			fly = true
			Mind.cat_found_in_room[Mind.in_room] = true
			Mind.cats_found += 1
			Mind.npc_dialoge_pointer[3][1] = 0
			TheEye.eye_check()
			#Mind.save_game()
	
	#Rotate head towards player
	var pos = Player.global_transform.origin
	var my = Head.global_transform.origin
	#print("pos.x : " + String(pos.x))
	#print("pos.z : " + String(pos.z))
	#print("my.x  : " + String(my.x))
#	print("my.z  : " + String(my.z))
	if pos.x-my.x == 0:
		my.x+=.001
	var angle = rad2deg(atan((pos.z-my.z)/(pos.x-my.x)))

	angle += 180
	if pos.x-my.x < 0:
		angle += 180
	
	angle = -deg2rad(angle)
	angle += PI*2
	#$Labels/Label1.text = "angle : " + String(angle)
	if Head.rotation.y > PI2:
		Head.rotation.y -= PI2
	if Head.rotation.y < 0:
		Head.rotation.y += PI2
	if abs(Head.rotation.y-angle) > PI:
		if angle > PI:
			angle -= PI2
		else:
			angle += PI2
	
	Head.rotation.y = lerp(Head.rotation.y, angle, .1)
	#$Labels/Label2.text = "Head.rotation.y : " + String(Head.rotation.y)
