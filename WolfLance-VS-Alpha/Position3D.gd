extends Position3D
var up_boundry = 80
var right_boundry = 150
var left_boundry = -150
var down_boundry = -80
export var Look_speed = 1500
var input_vector = Vector3.ZERO
var velocity = Vector3.ZERO
onready var ShipOrient2 = get_node("/root/main/rail/railcart/ShipOrient2")


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	input_vector.x = Input.get_action_strength("move_left") - Input.get_action_strength("move_right")
	input_vector.y = Input.get_action_strength("move_up") - Input.get_action_strength("move_down")
	input_vector = input_vector.normalized()
	self.transform.origin.x = clamp(self.transform.origin.x, left_boundry,right_boundry)
	self.transform.origin.y = clamp(self.transform.origin.y, down_boundry, up_boundry)
	velocity.x = input_vector.x * Look_speed * delta
	velocity.y = input_vector.y * Look_speed * delta 
	translate_object_local(velocity)
	self.look_at(ShipOrient2.global_transform.origin,Vector3.UP)
	

