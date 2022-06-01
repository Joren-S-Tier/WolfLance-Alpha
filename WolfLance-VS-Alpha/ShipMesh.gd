extends MeshInstance
onready var ShipOrient = get_node("/root/main/rail/railcart/ShipOrient")
export(NodePath) var target_scene
onready var target = get_node(target_scene)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_process(delta):
	self.look_at(ShipOrient.global_transform.origin,Vector3.UP)
