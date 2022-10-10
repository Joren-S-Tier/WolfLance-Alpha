extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mouseDelta

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _input(event):
	if event is InputEventMouseMotion:
		mouseDelta = event.relative
		
func _process(delta):
	$TerrainCamera.rotation_degrees.x -= mouseDelta.y * 10 * delta
	$TerrainCamera.rotation_degrees.x = clamp($TerrainCamera.rotation_degrees.x, -90,90)
	$TerrainCamera.rotation_degrees.y -= mouseDelta.x * 10 * delta
	mouseDelta = Vector2()
	
	
	
