extends Spatial

var timer = 0

func _ready():
	rnd_timer()

func _process(delta):
	timer -= 1
	if timer <= 0:
		rnd_timer()
		if visible:
			var val = floor(rand_range(1,5))
			if val == 1:
				$Meow1.play()
			if val == 2:
				$Meow2.play()
			if val == 3:
				$Meow3.play()
			if val >= 4:
				$Meow4.play()
			

func rnd_timer():
	timer = rand_range(100,300)
