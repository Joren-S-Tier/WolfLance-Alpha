extends KinematicBody

var moveSpeed = 10.0
var jumpSpeed = 10.0
var gravity = 15.0

var velocity = Vector3()
onready var camera = get_node("CameraHolder")

onready var SpringArm = $SpringArm
var rotate_up = Vector3(1, 0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	rotate_up = rotate_up.normalized()
	pass # Replace with function body.


func _physics_process(delta):
	velocity.x = 0
	velocity.z = 0
	
	var input = Vector3()
	
	
	
	if Input.is_action_pressed("move_right"):
		input.z += 1
	if Input.is_action_pressed("move_left"):
		input.z-= 1
	if Input.is_action_pressed("move_up"):
		input.x+= 1
	if Input.is_action_pressed("move_down"):
		input.x-= 1
		
		
	input = input.normalized()
	
	if Input.is_action_pressed("aim_right"):
		SpringArm.rotate_y(.01)
	if Input.is_action_pressed("aim_left"):
		SpringArm.rotate_y(-.01)
	if Input.is_action_pressed("aim_up"):
		#SpringArm.rotate_z(.01)
		SpringArm.rotate_object_local(rotate_up, .01)
	if Input.is_action_pressed("aim_down"):
		#SpringArm.rotate_z(-.01)
		SpringArm.rotate_object_local(rotate_up, -.01)
	
	
	var direction = (SpringArm.transform.basis.z * input.z + SpringArm.transform.basis.x *input.x)
	velocity.x = direction.x * moveSpeed
	velocity.z = direction.z * moveSpeed
	velocity.y -= gravity * delta
	
	
	if Input.is_action_pressed("boosting") and is_on_floor():
		velocity.y = jumpSpeed
		pass
	velocity = move_and_slide(velocity, Vector3.UP)

func display_subtitle(text):
	$Subtitle.visible = true
	$Subtitle.text = text
	$Timer.start()



func _on_Timer_timeout():
	$Subtitle.visible = false
