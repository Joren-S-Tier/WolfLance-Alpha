extends Sprite3D

onready var AimRayCast = get_node("/root/main/rail/railcart/Camera/RayCast")
onready var MainReticule = get_node("../aimingReticule")
var target_location = Vector3.ZERO



# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if AimRayCast.is_colliding():
		target_location = AimRayCast.get_collision_point()
		self.global_transform.origin = target_location
	else:
		self.global_transform.origin = MainReticule.global_transform.origin
