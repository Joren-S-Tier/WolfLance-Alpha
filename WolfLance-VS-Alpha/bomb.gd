extends RigidBody

export (PackedScene) var explosion = null
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
	var new_explosion = explosion.instance()
	$explosions.add_child(new_explosion)
	new_explosion.global_transform.origin = self.global_transform.origin
	print ("bomb hit")
	

func explode():
	var new_explosion = explosion.instance()
	$explosions.add_child(new_explosion)
	new_explosion.global_transform.origin = self.global_transform.origin
	print ("explosion")
	self.linear_velocity = Vector3.ZERO
	$MeshInstance.visible = false
