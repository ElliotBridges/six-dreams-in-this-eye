extends Spatial

onready var light1 = $Lightning1 
onready var light2 = $Lightning2
onready var light3 = $Lightning3 
onready var light4 = $Lightning4 
onready var light5 = $Lightning5 
onready var light6 = $Lightning6 

var lights = [light1,light2,light3,light4,light5,light6]

var timer = set_timer()
var max_time = 1050

var lightning_ref = null

func _ready():
	set_timer()

func _process(delta):
	if Mind.cats_found < 5:
		if round(timer) == 0:
			var val = round(rand_range(1,6))
			lightning_ref = get_node("Lightning" + String(val))
			lightning_ref.visible = true
			$Sounds.global_transform.origin = lightning_ref.global_transform.origin
			$Sounds/ASP3D.play()
			$Sounds/ASP3D/AudioStreamPlayer.play()
			$Label.text = ''
			for x in 5:
				var num = floor(rand_range(0,4.999))
				$Label.text += String(num)
				$Sounds/ASP3D.get_node("Hum"+String(num)).play()
				pass
	
	timer -= 1
	
	if timer <= -1050:
		if lightning_ref != null:
			$Sounds/Click.play()
			lightning_ref.visible = false
			set_timer()
			$Sounds/ASP3D.playing = false
			$Sounds/ASP3D/AudioStreamPlayer.playing = false
			$Sounds/ASP3D/Hum0.playing = false
			$Sounds/ASP3D/Hum1.playing = false
			$Sounds/ASP3D/Hum2.playing = false
			$Sounds/ASP3D/Hum3.playing = false
			$Sounds/ASP3D/Hum4.playing = false

func set_timer():
	timer = rand_range(200,200)



func _on_ASP3D_finished():
	if timer > max_time:
		max_time = timer + 50
