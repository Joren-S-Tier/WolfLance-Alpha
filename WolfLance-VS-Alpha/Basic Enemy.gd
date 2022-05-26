extends KinematicBody


export var health = 1
export var attack = 1
export var speed = 10
var target = null

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area_body_entered(body):
	if(body.is_in_group("Player")):
		body.player_takes_damage(attack)
	print ("hit")
	queue_free()
	
func _physics_process(delta):
	if target != null:
		self.look_at(target.global_transform.origin, Vector3.UP)
		var direction = self.global_transform.basis.z
		move_and_slide(direction *speed * -1)


func _on_PlayerDetection_body_entered(body):
	if(body.is_in_group("Player")):
		target = body
		
