extends Sprite3D

var upper_boundry = 80
var right_boundry = 150
var left_boundry = -150
var lower_boundry = -80
export var aiming_speed = 600
var input_vector = Vector3.ZERO
var velocity = Vector3.ZERO
onready var aimOrient = get_node("/root/main/rail/railcart/ship/aimingOrient")
var noInputTimerWentOff = false
var noInput = false
var timerRunning = false

export var returnspeed = 400

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	#print (aimOrient)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	input_vector.x =  Input.get_action_strength("aim_right") - Input.get_action_strength("aim_left")
	input_vector.y =  Input.get_action_strength("aim_up") - Input.get_action_strength("aim_down")
	print ("x==: ", input_vector.x)
	print ("y==: ", input_vector.y)
	if (input_vector.x==0 || input_vector.y==0):
		noInput = true
		#noInputTimerWentOff = false
	else:
			noInput = false
	print ("noInputIs: ", noInput)
	input_vector = input_vector.normalized()
	#input_vector.x = input_vector.x
	self.transform.origin.x = clamp(self.transform.origin.x, left_boundry,right_boundry)
	self.transform.origin.y = clamp(self.transform.origin.y, lower_boundry, upper_boundry)
	velocity.x = input_vector.x * aiming_speed * delta
	velocity.y = input_vector.y * aiming_speed * delta 
	translate_object_local(velocity)
	#print (self.transform.origin.x)
	#print (self.transform.origin.y)

	if (noInput):
		#print("no input")
		if(timerRunning ==false):
			$NoInputTimer.start()
			timerRunning = true
		if(noInputTimerWentOff):
			var position = self.transform.origin.move_toward(aimOrient.transform.origin,delta * returnspeed)
			#print (position)
			#print (self.transform.origin)
			self.transform.origin = position
	else:
		noInputTimerWentOff = false



func _on_NoInputTimer_timeout():
	noInputTimerWentOff = true
	timerRunning = false
