extends PathFollow


# Declare member variables here. Examples:
export var cartspeed = 250
var boost = 3


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.get_action_strength("boosting") >= 1:
		pass
		self.offset +=  (delta * cartspeed * boost)
	else:
		self.offset +=  (delta * cartspeed)
