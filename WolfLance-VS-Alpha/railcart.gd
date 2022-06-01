extends PathFollow

export(NodePath) var target_scene1
onready var RailTarget = get_node(target_scene1)
#onready var ship = $railcart/ship
#onready var camera = $railcart/Camera
#onready var position3D = $railcart/Position3D
export var cartspeed = 250
var boost = 3



func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	self.look_at(RailTarget.global_transform.origin,Vector3.UP)
	self.rotate_object_local(Vector3(0,1,0), 3.14)
	if Input.get_action_strength("boosting") >= 1:
		pass
		self.offset += delta * cartspeed * boost
	else:
		self.offset += delta * cartspeed
	



