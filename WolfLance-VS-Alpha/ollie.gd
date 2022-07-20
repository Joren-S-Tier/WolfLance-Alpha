extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var lineNumber = 0
var saidTheLine = false
var player_in_range = false
var can_talk = true
var dialog = null
onready var AudioPlayer = get_node("../AudioStreamPlayer")
export(NodePath) var target_scene
onready var target = get_node(target_scene)

var choiceNum = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	player_in_range = false
	$PlayerDetectionTimer.start()
	$ollietpose/AnimationPlayer.play("ollieIdle")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if (player_in_range &&Input.get_action_strength("shoot")>0 && can_talk):
		match lineNumber:
			0:
				AudioPlayer.set_volume_db(-40)
				dialog = Dialogic.start("ollie_tree")
				add_child(dialog)
				#lineNumber += 1
				can_talk = false
				#$Timer.set_wait_time(11)
				#$Timer.start()
			1:
#				dialog = Dialogic.start("ollie_npc_rant")
#				add_child(dialog)
#				lineNumber += 1
#				can_talk = false
#				$Timer.set_wait_time(20)
#				$Timer.start()
				pass
			2: 
				pass



func _on_player_detection_area_body_entered(body):
	#print("player detected")
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
		body.display_subtitle("Hello Dak")



func _on_player_detection_area_area_exited(area):
	player_in_range = false
	AudioPlayer.set_volume_db(-30)


func _on_Timer_timeout():
	can_talk = true
	remove_child(dialog)


func _on_PlayerDetectionTimer_timeout():
	$playerdetectionarea/CollisionShape.disabled = false
