extends KinematicBody

export (PackedScene) var heavy = null

export var health = 1
export var attack = 1
onready var railcart = get_node("%railcart")
onready var player = null
onready var frogPlayer = get_node("%frogPlayer")
export (PackedScene) var frogBubble = null
var shoot_speed = 10
var can_attack = true
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	frogPlayer.play("Idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func take_damage(damage):
	health -=damage
	if (health<=0):
		death()

func _on_Area_body_entered(body):
	if(body.is_in_group("Player")):
		body.player_takes_damage(attack)
	if(body.is_in_group("Projectile")):
		take_damage(1)
		#print ("hit")
	
	if(body.is_in_group("Bomb")):
		body.explode()
	
	if(health <=0):
		death()
	#print ("hit")
	#queue_free()


func _on_Area_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if(area.is_in_group("Projectile")):
		take_damage(1)

func _process(delta):
	if player:
		self.look_at(player.global_transform.origin, Vector3.UP)
		#print("look")
	

func _on_Area2_body_entered(body):
	pass
	


func attack():
	if can_attack:
		print("it's wednesday my dudes")
		frogPlayer.play("Attack")
		$attackDelay.start()
		can_attack =false
	


func _on_startupTimer_timeout():
	attack()


func _on_attackDelay_timeout():
	can_attack = true
	attack()
	
func fire_bubble():
	var direction = self.global_transform.basis.z
	var new_bubble = frogBubble.instance()
	new_bubble.rotation = self.rotation
	$projectiles.add_child(new_bubble)
	new_bubble.global_transform.origin = $projectileSpawnPosition.global_transform.origin
	new_bubble.linear_velocity = direction * shoot_speed* -1
	

func death():
	$attackDelay.stop()
	can_attack = false
	frogPlayer.play("Death")
