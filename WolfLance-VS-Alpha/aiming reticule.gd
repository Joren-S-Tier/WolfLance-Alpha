extends Sprite3D

var upper_boundry = 80
var right_boundry = 150
var left_boundry = -150
var lower_boundry = -80
export var aiming_speed = 10
var input_vector = Vector3.ZERO
var velocity = Vector3.ZERO


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	input_vector.x =  Input.get_action_strength("aim_right") - Input.get_action_strength("aim_left")
	input_vector.y =  Input.get_action_strength("aim_up") - Input.get_action_strength("aim_down")
	input_vector = input_vector.normalized()
	input_vector.x = input_vector.x
	self.transform.origin.x = clamp(self.transform.origin.x, left_boundry,right_boundry)
	self.transform.origin.y = clamp(self.transform.origin.y, lower_boundry, upper_boundry)
	velocity.x = input_vector.x * aiming_speed * delta
	velocity.y = input_vector.y * aiming_speed * delta 
	translate_object_local(velocity)
