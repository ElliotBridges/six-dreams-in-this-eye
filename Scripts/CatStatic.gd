extends Spatial

func _ready():
	if Mind.cats_found < 1:
		$Cat1.queue_free()
	if Mind.cats_found < 2:
		$Cat2.queue_free()
	if Mind.cats_found < 3:
		$Cat3.queue_free()
	if Mind.cats_found < 4:
		$Cat4.queue_free()
	if Mind.cats_found < 5:
		$Cat5.queue_free()
	
