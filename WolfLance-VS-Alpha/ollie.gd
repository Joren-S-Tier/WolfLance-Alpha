extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var lineNumber = 0
var saidTheLine = false
var player_in_range = false
var can_talk = true
var dialog = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player_in_range &&Input.get_action_strength("shoot")>0 && can_talk:
		match lineNumber:
			0:
				dialog = Dialogic.start("ollie talks")
				add_child(dialog)
				lineNumber += 1
				can_talk = false
				$Timer.set_wait_time(11)
				$Timer.start()
			1:
				dialog = Dialogic.start("ollie_npc_rant")
				add_child(dialog)
				lineNumber += 1
				can_talk = false
				$Timer.set_wait_time(20)
				$Timer.start()
			2: 
				pass



func _on_player_detection_area_body_entered(body):
	player_in_range = true
#	if body.is_in_group("Player") &&Input.get_action_strength("shoot")>0:
#		match lineNumber:
#			0:
#				var dialog1 = Dialogic.start("ollie talks")
#				add_child(dialog1)
#				lineNumber += 1
#			1:
#				var dialog2 = Dialogic.start("ollie_npc_rant")
#				add_child(dialog2)
#				lineNumber += 1
#			2: 
#				pass



func _on_Area_body_entered(body):
	if body.is_in_group("Player") &&saidTheLine==false:
		var dialog = Dialogic.start("ollie_ambient1")
		add_child(dialog)
		saidTheLine = true



func _on_player_detection_area_area_exited(area):
	player_in_range = false


func _on_Timer_timeout():
	can_talk = true
	remove_child(dialog)
