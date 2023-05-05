extends Node2D
var wakeable = false
var honk = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$interact.Change.connect(wakeSwitchOn)
	$interact.Back.connect(wakeSwitchOff)

func _process(_delta):
	bloom()

func wakeSwitchOn():
	print("wake me up inside")
	if !honk:
		wakeable = true
	
func wakeSwitchOff():
	print("can't wake up")
	wakeable = false	
	
func bloom():
	if wakeable and Input.is_action_just_pressed("blueAttack") and !honk:
		print("bloom")
		$AnimatedSprite2D.play("bloom")
		await $AnimatedSprite2D.animation_finished
		$AnimatedSprite2D.play("wake")
		honk = true
	else:
		pass	
