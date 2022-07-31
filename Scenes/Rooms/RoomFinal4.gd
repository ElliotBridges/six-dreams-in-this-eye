extends Spatial




func _on_Area_body_entered(body):
	$DirectionalLight.visible = true
	$Label.text = 'in'


func _on_Area_body_exited(body):
	$DirectionalLight.visible = false
	$Label.text = 'out'
