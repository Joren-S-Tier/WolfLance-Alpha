extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var randomInt = 0
var options = [1,2,3,4]

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()
	$startupTimer.start()
	#randomInt = abs(round(rand_range(1,4)))
	randomInt = options[randi() % options.size()]
	
	print (randomInt)



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
	match randomInt:
		1:
			$Explosion1.play()
		2:
			$Explosion2.play()
		3:
			$Explosion3.play()
		4:
			$Explosion4.play()
		
	#print (targets)
	for target in targets:
		if target.is_in_group(("Enemy")):
			target.take_damage(1)


func _on_EndTimer_timeout():
	queue_free()
