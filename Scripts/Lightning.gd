extends Spatial

var timer = 0

func _ready():
	set_timer()

func set_timer():
	timer = 10

func _process(delta):
	$Lightning1.translation.y = timer
	$Lightning2.translation.y = -timer
	timer -= 1
	if timer < -10:
		set_timer()
