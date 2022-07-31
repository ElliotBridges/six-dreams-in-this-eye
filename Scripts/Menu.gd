extends Control

func _ready():
	Mind.mouse_sense = $MouseSlider.value
	

func _process(delta):
	if Input.is_action_just_pressed("menu"):
		if Mind.talkingNode != null:
			Mind.talkingNode.stop_talking()
		visible = true
		get_tree().paused = true
		pause_mode = Node.PAUSE_MODE_PROCESS
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		if Mind.cats_found >= 1:
			$CatBox/Cat1.visible = true
		if Mind.cats_found >= 2:
			$CatBox/Cat2.visible = true
		if Mind.cats_found >= 3:
			$CatBox/Cat3.visible = true
		if Mind.cats_found >= 4:
			$CatBox/Cat4.visible = true
		if Mind.cats_found >= 5:
			$CatBox/Cat5.visible = true
	

		
func hide_menu():
	visible = false
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_ResumeButton_button_up():
	hide_menu()
	pass # Replace with function body.


func _on_MouseSlider_value_changed(value):
	Mind.mouse_sense = value
	pass # Replace with function body.


func _on_QuitButton_button_up():
	Mind.save_game()
	get_tree().quit()
	pass # Replace with function body.
