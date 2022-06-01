extends Position3D

export(NodePath) var target_scene
onready var target = get_node(target_scene)

func _physics_process(delta):
	#print (target)
	self.look_at(target.global_transform.origin, Vector3.UP)

