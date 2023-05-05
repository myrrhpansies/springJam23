extends Node2D
var wakeable = false
var honk = false


# Called when the node enters the scene tree for the first time.
func _ready():
	#signals supposed to connect
	$interact.Change.connect(wakeSwitchOn)
	$interact.Back.connect(wakeSwitchOff)

#
func wakeSwitchOn():
	#connect to this function if the Change signal is emitted
	print("wake me up")
	if !honk:
		wakeable = true
	else: 
		pass
	
func wakeSwitchOff():
	print("can't wake up")
	wakeable = false	
	
	
func bloom():
	if wakeable and Input.is_action_just_pressed("pinkAttack") and !honk:
		print("bloom")
		$AnimatedSprite2D.play("bloom")
		await $AnimatedSprite2D.animation_finished
		$AnimatedSprite2D.play("wake")
		honk = true
	else:
		pass	

func _process(_delta):
	bloom()


	

	
