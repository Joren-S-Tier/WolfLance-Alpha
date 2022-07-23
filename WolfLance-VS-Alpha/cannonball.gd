extends RigidBody

onready var target = get_node("/root/main/rail/railcart/ship/TrueAim")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start(.25)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	


func _on_Timer_timeout():
	queue_free()
