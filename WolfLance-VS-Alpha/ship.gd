extends KinematicBody

#this max health variable seems to control the health bar for some reason?
export var max_health = 3
export var current_health = 3
export var ship_speed = 5
export var roll_speed = 10
var velocity = Vector3.ZERO
onready var railcart = get_node("/root/main/rail/railcart")
onready var cannon = get_node("/root/main/rail/railcart/ship/ShipMesh/Cannon")
var right_boundry = 50
var left_boundry = -50
var down_boundry = -50
var up_boundry = 50
var input_vector = Vector3.ZERO
var down_position = Vector2(0.0, 0.0)

#onready var playerStats = get_node("PlayerStats")

export (PackedScene) var cannonball = null
export var shoot_strength = 750
var can_shoot = true
var mouse_is_down = false

var is_rolling = false
onready var animationPlayer = $AnimationPlayer
onready var cannonFireAudioPlayer = $audioPlayers/cannonFireSoundMaker

signal health_changed(value)

func _ready():
	$DodgeEffect.set_emitting(false)
	$BoostEffect.set_emitting(false)
	PlayerStats.set_max_health(max_health)
	



func _physics_process(delta):
	
	PlayerStats.set_health(current_health)
	
	#print (self.translation.x)
	#self.get_position() = clamp(global_position.x, left_boundry.position.x, right_boundry.position.x)
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_up") - Input.get_action_strength("move_down")
	input_vector = input_vector.normalized()
	self.transform.origin.x = clamp(self.transform.origin.x, left_boundry,right_boundry)
	self.transform.origin.y = clamp(self.transform.origin.y, down_boundry, up_boundry)
	
	if is_rolling == true:
		$DodgeEffect.set_emitting(true)
	
	if is_rolling == false:
		velocity.x = input_vector.x * ship_speed * delta
		velocity.y = input_vector.y * ship_speed * delta 
	
	if Input.get_action_strength("dodge roll")>=1:
		
		translate_object_local(velocity * roll_speed)
		
		is_rolling = true
		$rollTimer.start(.12)
		animationPlayer.play("roll")
	else:
		
		translate_object_local(velocity)
		
	if Input.get_action_strength("boosting")>=1:
		$BoostEffect.set_emitting(true)
	else:
		$BoostEffect.set_emitting(false)
	
	if Input.get_action_strength("shoot"):
		shoot()




func _on_Cooldown_timeout():
	can_shoot = true




func _on_rollTimer_timeout():
	is_rolling = false
	$DodgeEffect.set_emitting(false)

func player_takes_damage(damage):
	print("Player hit")
	current_health -= damage
	PlayerStats.set_health(current_health)
	
#	emit_signal("health_changed", current_health)
#	if current_health<=0:
#		print ("player death")


func _on_PlayerStats_no_health():
	print ("player death")
	
func shoot():
	if can_shoot:
		var cnr = cannon.global_transform.basis.z
		var rnr = railcart.transform.basis.z
		var new_cannon_ball = cannonball.instance()
		$cannonballs.add_child(new_cannon_ball)
		
		new_cannon_ball.global_transform.origin = $ShipMesh/Cannon/CannonBallSpawn.global_transform.origin
		print ("cannon Basis.Z=", cnr)
		print ("RailCart Basis.Z=", rnr)
		var vectorProduct = cnr * -1
		print ("Vector Product=", vectorProduct)
		new_cannon_ball.linear_velocity = vectorProduct * shoot_strength
		cannonFireAudioPlayer.play()
		can_shoot = false
		$cannonballCooldown.start()
