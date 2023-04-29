extends Node2D

var actionable = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func makeUnActionable():
	actionable = false	
	
func Waking():
		if actionable and Input.is_action_just_pressed("pinkAttack"):
			print('yeeee')
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
