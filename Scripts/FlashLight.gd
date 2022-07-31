extends Spatial

func _ready():
	global_transform.origin = Player.global_transform.origin
	#global_transform.origin.y += 1
