extends Spatial

var touchSpeed = 4.0
var minLookAngle = 8.0
var maxLookAngle = 10.0

var mouseDelta = Vector2()

onready var player = get_parent()

## Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.
#
#func _input(event):
#	pass
#	if event is InputEventMouseMotion:
#		mouseDelta = event.relative
#
#func _process(delta):
#	pass
#	var rotation = Vector3(mouseDelta.y, mouseDelta.x, 0) * touchSpeed *delta
#	rotation_degrees.x += rotation.x
#	rotation_degrees.x = clamp(rotation_degrees.x, minLookAngle, maxLookAngle)
#	player.rotation_degrees.y -=rotation.y
