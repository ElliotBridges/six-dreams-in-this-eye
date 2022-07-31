extends Spatial

func _ready():
	if Mind.cats_found == 0:
		get_parent().dialoge = ['3cats0a','3cats0b','3cats0c']
	if Mind.cats_found == 1:
		get_parent().dialoge = ['3cats1a','3cats1b']
	if Mind.cats_found == 2:
		get_parent().dialoge = ['3cats2a','3cats2b']
	if Mind.cats_found == 3:
		get_parent().dialoge = ['3cats3a','3cats3b']
	if Mind.cats_found == 4:
		get_parent().dialoge = ['3cats4a','3cats4b']
	if Mind.cats_found == 5:
		get_parent().dialoge = ['3cats5a','3cats5b','3cats5c']
	
