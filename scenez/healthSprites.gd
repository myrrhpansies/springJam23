extends AnimatedSprite2D
var bumps = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.healthySprites = self
	Global.player.healthChanged.connect(bumpCount)


func bumpCount():
	bumps -= 1

func changeSprite():
	if bumps == 5:
		set_frame_and_progress(0, 0)
	elif bumps == 4:
		set_frame_and_progress(1, 1)	
	elif bumps == 3:
		set_frame_and_progress(2, 2)
	elif bumps == 2:
		set_frame_and_progress(3, 3)
	elif bumps == 1:
		set_frame_and_progress(4, 4)
	elif bumps == 0:
		set_frame_and_progress(5, 5)
		
	
func _process(_delta):
	changeSprite()
