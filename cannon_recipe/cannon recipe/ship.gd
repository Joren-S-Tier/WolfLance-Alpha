extends KinematicBody

export var ship_speed = 5
export var roll_speed = 10
var velocity = Vector3.ZERO
onready var railcart = get_node("/root/main/rail/railcart")
var right_boundry = 50
var left_boundry = -50
var down_boundry = -50
var up_boundry = 50
var input_vector = Vector3.ZERO
var down_position = Vector2(0.0, 0.0)

export (PackedScene) var cannonball = null
export var shoot_strength = 750
var can_shoot = true
var mouse_is_down = false

var is_rolling = false
onready var animationPlayer = $AnimationPlayer



func _ready():
	pass



func _physics_process(delta):
	
	#print (self.translation.x)
	#self.get_position() = clamp(global_position.x, left_boundry.position.x, right_boundry.position.x)
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_up") - Input.get_action_strength("move_down")
	input_vector = input_vector.normalized()
	self.transform.origin.x = clamp(self.transform.origin.x, left_boundry,right_boundry)
	self.transform.origin.y = clamp(self.transform.origin.y, down_boundry, up_boundry)
	
	if is_rolling == false:
		velocity.x = input_vector.x * ship_speed * delta
		velocity.y = input_vector.y * ship_speed * delta 
	
	if Input.get_action_strength("dodge roll")>=1:
		
		translate_object_local(velocity * roll_speed)
		
		is_rolling = true
		$rollTimer.start(.12)
		animationPlayer.play("roll")
	else:
		
		translate_object_local(velocity)
		
	

func _input(event):
	pass
	if event is InputEventMouseButton:
		if event.button_index == 1:
			if event.pressed and can_shoot:
				down_position = event.position
				mouse_is_down = true
			elif mouse_is_down:
				mouse_is_down = false
				var new_cannon_ball = cannonball.instance()
				$cannonballs.add_child(new_cannon_ball)
				new_cannon_ball.global_transform.origin = $MeshInstance/CannonBallSpawn.global_transform.origin
				#var spawn_rotation = $MeshInstance/CannonBallSpawn.rotation
				new_cannon_ball.linear_velocity = railcart.transform.basis.z * shoot_strength
				
				
				can_shoot = false
				$cannonballCooldown.start()


func _on_Cooldown_timeout():
	can_shoot = true




func _on_rollTimer_timeout():
	is_rolling = false
