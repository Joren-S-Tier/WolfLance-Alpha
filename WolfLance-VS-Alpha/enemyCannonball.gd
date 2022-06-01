extends RigidBody
export var attack = 1

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start(10)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	queue_free()


func _on_cannonball_body_entered(body):
	if(body.is_in_group("Player")):
		body.player_takes_damage(attack)
	print ("hit")
	queue_free()
