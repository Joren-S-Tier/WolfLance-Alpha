extends PathFollow


#onready var rail = $rail
#onready var ship = $railcart/ship
#onready var camera = $railcart/Camera
#onready var position3D = $railcart/Position3D
var cartspeed = 250
var boost = 3


func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if Input.get_action_strength("boosting") >= 1:
		pass
		self.offset += delta * cartspeed * boost
	else:
		self.offset += delta * cartspeed
	
