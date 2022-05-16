extends Spatial

export (PackedScene) var cannonball = null

var can_shoot = true
var mouse_is_down = false
var down_position = Vector2(0.0, 0.0)
var shoot_strength = 0.2


func rotate_cannon(mouse_position):
	var mouse_delta = mouse_position - down_position
	$CSGSphere.look_at($CSGSphere.global_transform.origin + Vector3(0.0, mouse_delta.y, mouse_delta.x), Vector3(0.0, 1.0, 0))
	


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1:
			if event.pressed and can_shoot:
				down_position = event.position
				mouse_is_down = true
				
			elif mouse_is_down:
				mouse_is_down = false
				
				#rotate_cannon(event.position)
				
				var new_cannon_ball = cannonball.instance()
				$cannonballs.add_child(new_cannon_ball)
				new_cannon_ball.global_transform.origin = $CSGSphere/CannonballSpawn.global_transform.origin
				
				var mouse_delta = event.position - down_position
				new_cannon_ball.linear_velocity = Vector3(0.0, -1 * mouse_delta.y, -1 * mouse_delta.x) * shoot_strength
				
				can_shoot = false
				$Cooldown.start()
				
	elif event is InputEventMouseMotion:
		if mouse_is_down:
			rotate_cannon(event.position)
			
		
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_Cooldown_timeout():
	can_shoot = true
