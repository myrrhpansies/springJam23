extends CharacterBody2D

@export var speed : int = 35
@onready var animations = $AnimationPlayer

func handleInput():
	var moveDirection = Input.get_vector("left", "right", "up", "down")
	velocity = moveDirection * speed
	
func updateAnimation():
	if Input.is_action_just_pressed("left"):
		animations.play("left")
	if Input.is_action_just_pressed("right"):
		animations.play("right")	

func _physics_process(delta):
	updateAnimation()
	handleInput()
	move_and_slide()
