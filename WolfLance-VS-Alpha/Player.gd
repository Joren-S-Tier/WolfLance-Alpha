extends KinematicBody

var moveSpeed = 10.0
var jumpSpeed = 10.0
var gravity = 15.0
var anim_player
var is_moving = false

var velocity = Vector3()
onready var camera = $CameraOrbit

#onready var SpringArm = $SpringArm
var rotate_up = Vector3(1, 0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	rotate_up = rotate_up.normalized()
	pass # Replace with function body.
	anim_player = get_node("player animation test/AnimationPlayer")
	anim_player.play("idle")


func _physics_process(delta):
	
	velocity.x = 0
	velocity.z = 0
	
	var input = Vector3()
	
	if Input.is_action_pressed("move_up"):
		input.z+=1
		is_moving = true
	if Input.is_action_pressed("move_down"):
		input.z-=1
		is_moving = true
	if Input.is_action_pressed("move_right"):
		input.x-= 1
		is_moving = true
	if Input.is_action_pressed("move_left"):
		input.x +=1
		is_moving = true
	
	input = input.normalized()
	
	if input == Vector3.ZERO:
		is_moving = false
	
	var dir = (transform.basis.z * input.z + transform.basis.x * input.x)
	
	velocity.x = dir.x *moveSpeed
	velocity.z = dir.z *moveSpeed
	
#	self.look_at($SpringArm/PlayerOrient.global_transform.origin, Vector3.UP)
#
#	if Input.is_action_pressed("move_right"):
#		input.z += 1
#	if Input.is_action_pressed("move_left"):
#		input.z-= 1
#	if Input.is_action_pressed("move_up"):
#		input.x+= 1
#	if Input.is_action_pressed("move_down"):
#		input.x-= 1
	
#	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
#	input_vector.y = Input.get_action_strength("move_up") - Input.get_action_strength("move_down")
#	input_vector = input_vector.normalized()
#
#
#	velocity.z= input_vector.y * moveSpeed
#	velocity.x = input_vector.x * moveSpeed
	
	if Input.is_action_pressed("aim_right"):
		pass
		#print (SpringArm.rotation.y)
		#SpringArm.rotate_y(clamp(SpringArm.rotation.y+.01,-5,5))
		#SpringArm.rotate_y(.01)
	if Input.is_action_pressed("aim_left"):
		pass
		#print (SpringArm.rotation.y)
		#SpringArm.rotate_y(clamp(SpringArm.rotation.y-.01,-5,5))
		#SpringArm.rotate_y(-.01)
	if Input.is_action_pressed("aim_up"):
		pass
		#print (SpringArm.rotation.x)
		#SpringArm.rotate_z(.01)
		#SpringArm.rotate_object_local(rotate_up, .01)
	if Input.is_action_pressed("aim_down"):
		pass
		#SpringArm.rotate_z(-.01)
		#print (SpringArm.rotation.x)
		#SpringArm.rotate_object_local(rotate_up, -.01)
	
	var anim_to_play = "idle"
	if is_moving:
		anim_to_play = "walk"
	else:
		anim_to_play = "idle"
	
	var current_anim = anim_player.get_current_animation()
	if current_anim != anim_to_play:
		anim_player.play(anim_to_play)
	
	#var direction = (SpringArm.transform.basis.z * input.z), (SpringArm.transform.basis.x *input.x)
	#velocity.x = direction.x * moveSpeed
	#velocity.z = direction.z * moveSpeed
	velocity.y -= gravity * delta
	
	
	if Input.is_action_pressed("boosting") and is_on_floor():
		#velocity.y = jumpSpeed
		pass
	velocity = move_and_slide(velocity, Vector3.UP)

func display_subtitle(text):
	$Subtitle.visible = true
	$Subtitle.text = text
	$Timer.start()



func _on_Timer_timeout():
	$Subtitle.visible = false


func _on_VideoPlayer_finished():
	$VideoPlayer.visible=false
