extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()
	$startupTimer.start()



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	$MeshInstance.visible = false
	$CollisionShape.disabled = true
	$EndTimer.start()


func _on_explosion_body_entered(body):
	if body.is_in_group("Enemy"):
		#print ("Enemy hit by explosion")
		pass


func _on_startupTimer_timeout():
	var targets = get_overlapping_bodies()
	$AudioStreamPlayer.play()
	#print (targets)
	for target in targets:
		if target.is_in_group(("Enemy")):
			target.take_damage(1)


func _on_EndTimer_timeout():
	queue_free()
