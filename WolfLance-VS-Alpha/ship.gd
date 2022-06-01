extends KinematicBody

#this max health variable seems to control the health bar for some reason?
export var max_health = 3
export var current_health = 3
export var ship_speed = 5
export var roll_speed = 10
var velocity = Vector3.ZERO
onready var railcart = get_node("/root/main/rail/railcart")
onready var cannon = get_node("/root/main/rail/railcart/ship/ShipMesh/Cannon")
onready var ShipMesh = get_node("/root/main/rail/railcart/ship/ShipMesh")
onready var ShipOrient = get_node("/root/main/rail/railcart/ShipOrient")
onready var bEmitter = get_node("/root/main/rail/railcart/ship/ShipMesh/BoostEffect")
onready var dEmitter = get_node("/root/main/rail/railcart/ship/ShipMesh/DodgeEffect")
var right_boundry = 50
var left_boundry = -50
var down_boundry = -50
var up_boundry = 50
var forward_boundry = -5
var backward_boundry = 5
var input_vector = Vector3.ZERO
var down_position = Vector2(0.0, 0.0)

var first_boost = true

#onready var playerStats = get_node("PlayerStats")

export (PackedScene) var cannonball = null
export (PackedScene) var bomb = null
export var shoot_strength = 750
var can_shoot = true
var mouse_is_down = false

var is_rolling = false
onready var animationPlayer = $AnimationPlayer
onready var cannonFireAudioPlayer = $audioPlayers/cannonFireSoundMaker
onready var playerHitAudioPlayer = $audioPlayers/playerHitSoundMaker
onready var dodgeBoostSoundPlayer = $audioPlayers/dodgeBoostSoundMaker
onready var boostSoundPlayer = $audioPlayers/boostSoundMaker
onready var longBoostPlayer = $audioPlayers/continousBoostSoundMaker
signal health_changed(value)

func _ready():
	dEmitter.set_emitting(false)
	bEmitter.set_emitting(false)
	PlayerStats.set_max_health(max_health)
	



func _physics_process(delta):
	
	PlayerStats.set_health(current_health)
	ShipMesh.look_at(ShipOrient.global_transform.origin,Vector3.UP)
	ShipMesh.rotate_object_local(Vector3(0,1,0), 3.14)
	#print (self.translation.x)
	#self.get_position() = clamp(global_position.x, left_boundry.position.x, right_boundry.position.x)
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_up") - Input.get_action_strength("move_down")
	input_vector = input_vector.normalized()
	self.transform.origin.x = clamp(self.transform.origin.x, left_boundry,right_boundry)
	self.transform.origin.y = clamp(self.transform.origin.y, down_boundry, up_boundry)
	#self.transform.origin.z = clamp(self.transform.origin.y, forward_boundry, backward_boundry)
	
	if is_rolling == true:
		dEmitter.set_emitting(true)
		if dodgeBoostSoundPlayer.is_playing() == false:
			dodgeBoostSoundPlayer.play()
	
	if is_rolling == false:
		velocity.x = input_vector.x * ship_speed * delta
		velocity.y = input_vector.y * ship_speed * delta 
	
	if Input.get_action_strength("dodge roll")>=1:
		dodgeRoll()
	else:
		
		translate(velocity)
		
	if Input.get_action_strength("boosting")>=1:
		startBoostFX()
	else:
		stopBoostFX()
	if Input.get_action_strength("shoot"):
		shoot()
	if Input.get_action_strength("bomb"):
		shoot_bomb()

func dodgeRoll():
	translate_object_local(velocity * roll_speed)
	is_rolling = true
	$ShipMesh/Cannon/reticule1.visible = false
	$ShipMesh/Cannon/reticule2.visible = false
	$rollTimer.start(.12)
	animationPlayer.play("roll")


func startBoostFX():
	bEmitter.set_emitting(true)
	if boostSoundPlayer.is_playing() == false && first_boost == true:
		boostSoundPlayer.play()
		longBoostPlayer.play()

func stopBoostFX():
	bEmitter.set_emitting(false)
	boostSoundPlayer.stop()
	longBoostPlayer.stop()
	first_boost = true

func _on_Cooldown_timeout():
	can_shoot = true




func _on_rollTimer_timeout():
	is_rolling = false
	$ShipMesh/Cannon/reticule1.visible = true
	$ShipMesh/Cannon/reticule2.visible = true
	dEmitter.set_emitting(false)

func player_takes_damage(damage):
	print("Player hit")
	current_health -= damage
	PlayerStats.set_health(current_health)
	playerHitAudioPlayer.play()
	
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


func _on_boostSoundMaker_finished():
	first_boost = false

func shoot_bomb():
	if can_shoot:
		var cnr = cannon.global_transform.basis.z
		var rnr = railcart.transform.basis.z
		var new_bomb = bomb.instance()
		$cannonballs.add_child(new_bomb)
		new_bomb.global_transform.origin = $ShipMesh/Cannon/CannonBallSpawn.global_transform.origin
		print ("cannon Basis.Z=", cnr)
		print ("RailCart Basis.Z=", rnr)
		var vectorProduct = cnr * -1
		print ("Vector Product=", vectorProduct)
		new_bomb.linear_velocity = vectorProduct * shoot_strength
		cannonFireAudioPlayer.play()
		can_shoot = false
		$cannonballCooldown.start()
