extends KinematicBody


export var health = 1
export var attack = 1
export var speed = 10
var target = null
export var shoot_strength = 10
export (PackedScene) var enemyCannonball = null
var can_fire = true

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area_body_entered(body):
	if(body.is_in_group("Player")):
		body.player_takes_damage(attack)
	#print ("hit")
	#queue_free()
	
func _physics_process(delta):
	if target != null:
		if can_fire:
			self.look_at(target.global_transform.origin, Vector3.UP)
			var direction = self.global_transform.basis.z
			var new_cannonball = enemyCannonball.instance()
			$Cannonballs.add_child(new_cannonball)
			new_cannonball.global_transform.origin = $cannonfireSpawn.global_transform.origin
			new_cannonball.linear_velocity = direction * shoot_strength * -1
			can_fire = false
			$Cooldown.start()


func _on_PlayerDetection_body_entered(body):
	if(body.is_in_group("Player")):
		target = body
		#print ("player detected")
		#print (target)


func _on_Cooldown_timeout():
	can_fire = true
