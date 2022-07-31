extends MeshInstance

func _ready():
	global_transform.origin.y += Mind.cats_found*10
