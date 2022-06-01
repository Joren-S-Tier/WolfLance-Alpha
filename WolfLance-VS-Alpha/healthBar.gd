extends ProgressBar
#
#export var  playerMaxHealth = 5
#onready var player = ("../../rail/railcart/ship")
#export var playerCurrentHealth=4
#
#
## Declare member variables here. Examples:
## var a = 2
## var b = "text"
#
#
## Called when the node enters the scene tree for the first time.
func _ready():
	self.max_value = PlayerStats.max_health
#
#func health_changed(value):
#
#	playerCurrentHealth = value
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.value = PlayerStats.get("health")
#	Ship.connect("health_changed", self, "health_changed")

#

