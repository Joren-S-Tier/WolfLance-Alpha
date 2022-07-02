extends Control

func _input (event):
	if event.is_action_pressed("pause"):
		get_tree().paused = not get_tree().paused
		self.visible = not self.visible
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_Button_pressed():
	get_tree().paused = not get_tree().paused
	self.visible = not self.visible
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_Button2_pressed():
	get_tree().quit()
