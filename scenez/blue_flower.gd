extends Node2D
var wakeable = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$interact.Change.connect(wakeSwitchOn)
	$interact.Back.connect(wakeSwitchOff)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	bloom()

func wakeSwitchOn():
	wakeable = true
	
func wakeSwitchOff():
	wakeable = false	
func bloom():
	if wakeable and Input.is_action_just_pressed("blueAttack"):
		$AnimatedSprite2D.play("bloom")
		await $AnimatedSprite2D.animation_finished
		$AnimatedSprite2D.play("wake")
	else:
		pass	
