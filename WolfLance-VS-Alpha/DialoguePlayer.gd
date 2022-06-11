extends CanvasLayer


#export(String, FILE, "*.txt") var dialogue_file
#
#
#var dialogues = []
#var current_dialogue_id = 0
#
#func _ready():
#	play()
#
#
#func play():
#	dialogues = load_dialogue()
#	current_dialogue_id = -1
#	#next_line()
#
#func load_dialogue():
#	var file = File.new()
#	if(file.file_exists(dialogue_file)):
#		file.open(dialogue_file, file.READ)
#		return file.get_as_text()
#
#func _input(event):
#	if event.is_action_pressed("shoot"):
#		next_line()
#
#
#func next_line():
#	current_dialogue_id += 1
#
#	if current_dialogue_id >= len(dialogues):
#		return
#
#	$NinePatchReact/name.text = dialogues[current_dialogue_id]["name"]
#	$NinePatchRect/message.text = dialogues[current_dialogue_id]["text"]
