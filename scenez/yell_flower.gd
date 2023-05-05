extends Node2D
var wakeable = false
var honk = false


# Called when the node enters the scene tree for the first time.
func _ready():
#	$interact.Change.connect(wakeSwitchOn)
	#$interact.Back.connect(wakeSwitchOff)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	bloom()

func wakeSwitchOn():
	if !honk:
		wakeable = true
	
func wakeSwitchOff():
	wakeable = false	
	
func bloom():
	if !honk and wakeable and Input.is_action_just_pressed("yellAttack") :
		$arise.play("bloom")
		await $arise.animation_finished
		$arise.play("wake")
		honk = true
	else:
		pass
