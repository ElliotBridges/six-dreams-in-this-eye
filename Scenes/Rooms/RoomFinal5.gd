extends Spatial

var done = false

func _process(delta):
	if Mind.cats_found < 5 and done == false:
		$AudioStreamPlayer3D.playing = true
		$AudioStreamPlayer3D2.playing = true
		$AudioStreamPlayer3D3.playing = true
		$AudioStreamPlayer3D4.playing = true
		$AudioStreamPlayer2.playing = true
		done = true

