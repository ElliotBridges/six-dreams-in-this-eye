extends Spatial

func _ready():
	var dialog = Dialogic.start('1')
	add_child(dialog)
