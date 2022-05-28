extends Position3D

#this max health variable seems to control the health bar for some reason?

export var ship_speed = 5
export var roll_speed = 10
var velocity = Vector3.ZERO
var right_boundry = 50
var left_boundry = -50
var down_boundry = -50
var up_boundry = 50
var forward_boundry = -5
var backward_boundry = 5
var input_vector = Vector3.ZERO
var down_position = Vector2(0.0, 0.0)

var first_boost = true
var is_rolling = false

func _ready():
	pass
	



func _physics_process(delta):
	
	
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_up") - Input.get_action_strength("move_down")
	input_vector = input_vector.normalized()
	self.transform.origin.x = clamp(self.transform.origin.x, left_boundry,right_boundry)
	self.transform.origin.y = clamp(self.transform.origin.y, down_boundry, up_boundry)
	
	
	if is_rolling == false:
		velocity.x = input_vector.x * ship_speed * delta * -1
		velocity.y = input_vector.y * ship_speed * delta 
	
	if Input.get_action_strength("dodge roll")>=1:
		dodgeRoll()
	else:
		translate(velocity)
		
func dodgeRoll():
	translate_object_local(velocity * roll_speed)
	is_rolling = true
	$rollTimer.start(.12)

func _on_rollTimer_timeout():
	is_rolling = false
	

	
