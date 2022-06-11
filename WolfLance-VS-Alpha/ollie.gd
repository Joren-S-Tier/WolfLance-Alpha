extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var lineNumber = 0
var saidTheLine = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_player_detection_area_body_entered(body):
	if body.is_in_group("Player") &&saidTheLine==false:
		match lineNumber:
			0:
				var dialog = Dialogic.start("ollie talks")
				add_child(dialog)
				lineNumber += 1
			1:
				var dialog = Dialogic.start("ollie_npc_rant")
				add_child(dialog)
				lineNumber += 1
			2: 
				saidTheLine =true

