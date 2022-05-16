extends Spatial

var max_health = 3
onready var health = max_health setget set_health

signal no_health

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_max_health(value):
	max_health = value

func set_health(value):
	health = value
	if health<=0:
		emit_signal("no_health")


