extends CanvasLayer

var playerGlobalTransform = Vector3()

var cats_found = 0

var cat_found_in_room = [false, false, false, false, false, false, false]

var npc_dialoge_pointer = [[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0]]

var talkingNode = null
var mouse_sense = .25

var in_room = 0

var save_path = "user://save.dat"

var player_globals = null

var world = null

func _ready():
	load_game()
	randomize()

func _process(delta):
	$VBox/Label1.text = "world 1 npc 1 pointer: " + String(npc_dialoge_pointer[1][1])
	$VBox/Label2.text = "found cat in this dream? : " + String(cat_found_in_room[in_room])

func change_scene(scene):
	get_tree().change_scene(scene)
#	if world != null:
#		world.queue_free()
#	world = Spatial.new()
#	add_child(world)
#	var room = load(scene)
#	world.add_child(room.instance())
	
	in_room = int(scene)

	#Player.global_transform.basis = playerGlobalTransform

func save_game():
	var file = File.new()
	var error = file.open(save_path, File.WRITE)
	if error == OK:
		file.store_var(cat_found_in_room)
		file.store_var(npc_dialoge_pointer)
		file.store_var(cats_found)
		file.store_var(mouse_sense)
		file.store_var(Player.global_transform.origin)
		file.store_var(in_room)
		file.close()
	
func load_game():
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open(save_path, File.READ)
		if error == OK:
			cat_found_in_room = file.get_var()
			npc_dialoge_pointer = file.get_var()
			cats_found = file.get_var()
			mouse_sense = file.get_var()
			player_globals = file.get_var()
			in_room = file.get_var()
			file.close()
	Mind.change_scene("res://Scenes/Rooms/RoomFinal"+String(in_room)+".tscn")
