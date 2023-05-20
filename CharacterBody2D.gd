extends CharacterBody2D
var Speed: int = 300

func handleInput():
	var moveDirection = Input.get_vector("left", "right", "up", "down")
	velocity = moveDirection * Speed
	
func updateAnimation():
	if Input.is_action_just_pressed("left"):
		scale.y = 1
		rotation_degrees = 0
	elif Input.is_action_just_pressed("right"):
		scale.y = -1
		rotation_degrees = 180	

func _physics_process(_delta):
	handleInput()
	updateAnimation()
	move_and_slide()
