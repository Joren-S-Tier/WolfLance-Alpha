extends RayCast


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var status = "test"
#export(NodePath) var target_scene
onready var TrueAim = get_node("/root/main/rail/railcart/ship/aimingReticule")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	self.look_at(TrueAim.global_transform.origin,Vector3.UP)
	status = self.is_colliding();
	#print(status)
	
