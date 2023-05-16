extends Node2D
var wakeable = false
var honk = false
signal bloomIt

func _ready():
	$interact.Change.connect(wakeSwitchOn)
	$interact.Back.connect(wakeSwitchOff)
	
func wakeSwitchOn():
	if !honk:
		wakeable = true

func wakeSwitchOff():
	wakeable = false	
	print("wake" +str(wakeable))

func bloom():
	if wakeable and Input.is_action_just_pressed("blueAttack") and !honk:
			$arise.play("bloom")
			await $arise.animation_finished
			$arise.play("wake")
			honk = true

func _process(_delta):
	bloom()
