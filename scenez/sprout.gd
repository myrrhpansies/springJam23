extends CharacterBody2D

@export var speed : int = 35

func handleInput():
	var moveDirection = Input.get_vector("left", "right", "up", "down")
	velocity = moveDirection * speed
	if Input.is_action_just_pressed("right"):
		$sproutSprite.flip_h()

func _physics_process(delta):
	handleInput()
	move_and_slide()
