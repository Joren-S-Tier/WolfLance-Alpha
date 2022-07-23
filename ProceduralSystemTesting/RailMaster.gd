extends Path


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#var GameManager = preload("res://GameManager.tscn");
#var GameScript = preload("res://GameManager.gd");
onready var GameManager = get_node("/root/GameManager")

# Called when the node enters the scene tree for the first time.
func _ready():
	var newcurve = GameManager.railgen()
	set_curve(newcurve)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
