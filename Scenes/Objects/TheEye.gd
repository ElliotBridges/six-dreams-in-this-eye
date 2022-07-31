extends Spatial



func _ready():
	pass

func eye_check():
	if Mind.cats_found >= 5 and visible == false:
		visible = true
		$AudioStreamPlayer.playing = true

