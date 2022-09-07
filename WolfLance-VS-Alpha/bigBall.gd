extends RigidBody

onready var target = get_node("/root/main/rail/railcart/ship/TrueAim")
onready var parentGun = get_node("/root/main/rail/railcart/ship/ShipMesh/Cannon/CannonBallSpawn")
var cnr = null
var rnr = null
var new_big_ball = self
var shoot_strength = 750
var charge_stage = 1
var material : SpatialMaterial = null
var default_color = null
var middle_color = Color.yellow
var final_color = Color.red
var can_charge = true

# Declare member variables here. Examples:
#ShipMesh/Cannon/CannonBallSpawn
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	$ChargeTimer.start()

func release():
	print ("fire big ball")
	$ChargeTimer.stop()
	

	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta):


#	if parentGun!=null:
#		print (parentGun.transform.origin)


func _on_Timer_timeout():
	queue_free()

func advance_charge():
	charge_stage += 1
	if charge_stage >= 4:
		charge_stage =4
	ball_change(charge_stage)

func ball_change(charge_stage):
	match charge_stage:
		1:
			print ("big ball stage 1")
		2:
			print ("big ball stage 2 test")
			#$MeshInstance.material_override.albedo_color = Color.yellow
			var newMaterial = SpatialMaterial.new()
			newMaterial.albedo_color = Color.red
			$"MeshInstance".material_override = newMaterial
			#self.scale =Vector3(12,12,12)
			self.scale =Vector3(16,16,16)
		3:
			print ("big ball stage 3")
			var newMaterial = SpatialMaterial.new()
			newMaterial.albedo_color = Color.purple
			$"MeshInstance".material_override = newMaterial
			#self.scale =Vector3(18,18,18)
			self.scale =Vector3(32,32,32)
		4:
			print ("max")
			var newMaterial = SpatialMaterial.new()
			newMaterial.albedo_color = Color.purple
			$"MeshInstance".material_override = newMaterial
			self.scale =Vector3(32,32,32)
			
	


func _on_ChargeTimer_timeout():
	advance_charge()
