extends Control

func _input (event):
	if event.is_action_pressed("pause"):
		get_tree().paused = not get_tree().paused
		self.visible = not self.visible


func _on_Button_pressed():
	get_tree().change_scene(("res://main.tscn"))


func _on_Button2_pressed():
	get_tree().change_scene(("res://HardSell.tscn"))


func _on_TextureButton_pressed():
	self.visible = not self.visible
